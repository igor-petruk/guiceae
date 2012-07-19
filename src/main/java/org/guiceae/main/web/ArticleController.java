package org.guiceae.main.web;

import com.google.appengine.api.users.UserServiceFactory;
import com.sun.jersey.api.view.Viewable;
import org.guiceae.main.model.Article;
import org.guiceae.main.repositories.ArticleRepository;

import javax.annotation.security.RolesAllowed;
import javax.inject.Inject;
import javax.ws.rs.*;
import javax.ws.rs.core.Response;
import java.net.URI;
import java.net.URISyntaxException;

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
        return new Viewable("/articleDetail.jsp", article);
    }

    @GET
    @Path("/add/{feed}")
    @RolesAllowed("cm")
    public Viewable addArticle(@PathParam("feed") String feed) {
        Article article = new Article();
        article.setFeed(feed);
        article.setId(0L);
        article.setMainPhotoUrl("http://upload.wikimedia.org/wikipedia/commons/thumb/c/c5/Egypt.Giza.Sphinx.01.jpg/312px-Egypt.Giza.Sphinx.01.jpg");
        article.setContent("Зміст");
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
                                @FormParam("title") String title,
                                @FormParam("permalink") String permalink,
                                @FormParam("content") String content,
                                @FormParam("shortContent") String shortContent) throws URISyntaxException {
        Article article = new Article();
        article.setId(id);
        article.setContent(content);
        article.setFeed(feed);
        article.setTitle(title);
        article.setPermalink(permalink);
        article.setContent(content);
        article.setShortContent(shortContent);
        if (article.getAuthor() == null) {
            article.setAuthor(UserServiceFactory.getUserService().getCurrentUser().getNickname());
        }
        articleRepository.mergeArticle(article);
        return Response.seeOther(new URI("/app/feed/" + article.getFeed())).build();
    }
}
