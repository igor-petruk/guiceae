package org.guiceae.main.web;

import com.google.appengine.api.users.UserServiceFactory;
import com.sun.jersey.api.view.Viewable;
import org.apache.http.NameValuePair;
import org.apache.http.client.utils.URLEncodedUtils;
import org.guiceae.main.model.Article;
import org.guiceae.main.repositories.ArticleRepository;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.nodes.Node;
import org.jsoup.parser.Tag;
import org.jsoup.safety.Whitelist;

import javax.annotation.security.RolesAllowed;
import javax.inject.Inject;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.net.MalformedURLException;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Path("/app/article")
public class ArticleController {
    @Inject
    ArticleRepository articleRepository;

    @GET
    @Path("/edit/{id}")
    @RolesAllowed("cm")
    public Viewable editArticle(@PathParam("id") Long id) {
        Article article = articleRepository.getArticle(id);
        return new Viewable("/editArticle.jsp", article);
    }

    @GET
    @Path("/detail/{permalink}")
    public Viewable detail(@PathParam("permalink") String permalink) {
        Article article = articleRepository.getArticleByPermalink(permalink);
        if (article != null)
            return new Viewable("/articleDetail.jsp", article);
        else
            throw new WebApplicationException(Response.Status.NOT_FOUND);
    }

    @GET
    @Path("/validatePermalink/{id}/{current}")
    @Produces(MediaType.TEXT_PLAIN)
    public String validatePermalink(@PathParam("current") String current,
                                    @PathParam("id") Long id,
                                    @QueryParam("permalink") String permalink) {
        if (id != 0 && current.equals(permalink)) {
            return "true";
        } else {
            return String.valueOf(!articleRepository.permalinkExists(permalink));
        }
    }

    @GET
    @Path("/add/{feed}")
    @RolesAllowed("cm")
    public Viewable addArticle(@PathParam("feed") String feed) {
        Article article = new Article();
        article.setFeed(feed);
        article.setId(0L);
        article.setEditableContent("Зміст");
        article.setShortContent("Короткий зміст");
        article.setTitle("Заголовок статті");
        article.setPermalink("zagolovok-statti");
        return new Viewable("/editArticle.jsp", article);
    }

    @DELETE
    @Path("/delete/{id}")
    @RolesAllowed("cm")
    public Response delete(@PathParam("id") Long id) throws URISyntaxException {
        articleRepository.delete(id);
        return Response.ok().build();
    }

    @POST
    @Path("/publish/{id}")
    @RolesAllowed("cm")
    public Response publish(@PathParam("id") Long id) throws URISyntaxException {
        articleRepository.publish(id);
        return Response.ok().build();
    }

    @POST
    @Path("/save")
    @RolesAllowed("cm")
    public Response saveArticle(@FormParam("id") Long id,
                                @FormParam("feed") String feed,
                                @FormParam("toView") Date toView,
                                @FormParam("title") String title,
                                @FormParam("permalink") String permalink,
                                @FormParam("mainImage") String mainPhotoUrl,
                                @FormParam("editableContent") String editableContent,
                                @FormParam("shortContent") String shortContent) throws URISyntaxException, MalformedURLException {
        Article article = new Article();
        article.setId(id);
        article.setFeed(feed);
        article.setTitle(title);
        article.setToView(toView);
        Article oldArticle = articleRepository.getArticleByPermalink(permalink);
        if ((oldArticle != null) && !(oldArticle.getId().equals(id))) {
            throw new WebApplicationException(Response.Status.BAD_REQUEST);
        }
        article.setPermalink(permalink);
        article.setMainPhotoUrl(mainPhotoUrl);

        Document shortContentDoc = parseDocument(shortContent);
        transformImages(shortContentDoc);
        article.setShortContent(shortContentDoc.toString());

        Document contentDoc = parseDocument(editableContent);
        transformImages(contentDoc);
        article.setEditableContent(contentDoc.toString());
        transformVideos(contentDoc);
        article.setContent(contentDoc.toString());

        if (article.getAuthor() == null) {
            article.setAuthor(UserServiceFactory.getUserService().getCurrentUser().getNickname());
        }
        articleRepository.mergeArticle(article);
        return Response.seeOther(new URI("/app/feed/" + article.getFeed())).build();
    }

    private Document parseDocument(String content) {
        Document doc = Jsoup.parse(Jsoup.clean(content, Whitelist
                .relaxed()
                .addTags("span")
                .addAttributes(":all", "style", "class")));
        return doc;
    }

    private void transformVideos(Document document) throws MalformedURLException, URISyntaxException {
        for (Element e : document.select("a")) {
            String href = e.attr("href");
            URI uri = new URI(href);
            List<NameValuePair> nameValuePairs = URLEncodedUtils.parse(uri, "UTF-8");
            String v = null;
            for (NameValuePair nameValuePair : nameValuePairs) {
                if ("v".equals(nameValuePair.getName().toLowerCase())) {
                    v = nameValuePair.getValue();
                }
            }
            if (uri.getHost().toLowerCase().equals("www.youtube.com") && v != null) {
                Node node = new Element(Tag.valueOf("iframe"), "");
                node.attr("type", "text/html");
                node.attr("src", "http://www.youtube.com/embed/" + v);
                node.attr("width", "680");
                node.attr("height", "390");
                e.replaceWith(node);
            }
        }
    }

    private void transformImages(Document document) {
        for (Element e : document.select("img")) {
            String[] styleAttrs = e.attr("style").split(";");
            Map<String, String> styleMap = new HashMap<String, String>();
            for (String attr : styleAttrs) {
                if (attr.contains(":")) {
                    String[] token = attr.split(":");
                    styleMap.put(token[0].trim().toLowerCase(), token[1].trim());
                }
            }
            if (styleMap.containsKey("height") && styleMap.containsKey("width")) {
                String ws = styleMap.get("width");
                String hs = styleMap.get("height");
                if (ws.endsWith("px")) ws = ws.substring(0, ws.lastIndexOf("px"));
                if (hs.endsWith("px")) hs = hs.substring(0, hs.lastIndexOf("px"));
//                System.out.println("(" + ws + ")");
//                System.out.println("(" + hs + ")");
                int width = Integer.parseInt(ws);
                int height = Integer.parseInt(hs);
                String url = e.attr("src");
                if (url.matches("^.*=s\\d+$")) {
                    url = url.substring(0, url.lastIndexOf('='));
                }
                e = e.attr("src", url + "=s" + Math.max(height, width));
            }
        }
    }
}
