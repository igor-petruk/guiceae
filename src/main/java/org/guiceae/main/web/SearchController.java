package org.guiceae.main.web;

import com.google.appengine.api.search.Results;
import com.google.appengine.api.search.ScoredDocument;
import com.sun.jersey.api.view.Viewable;
import org.guiceae.main.model.Article;
import org.guiceae.main.model.ArticleState;
import org.guiceae.main.repositories.SearchRepository;
import org.guiceae.util.UserPrincipalHolder;

import javax.inject.Inject;
import javax.ws.rs.DefaultValue;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.QueryParam;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Path("/app/search")
public class SearchController {
    SearchRepository searchRepository;
    UserPrincipalHolder userPrincipalHolder;

    @Inject
    public SearchController(SearchRepository searchRepository,UserPrincipalHolder userPrincipalHolder) {
        this.searchRepository = searchRepository;
        this.userPrincipalHolder = userPrincipalHolder;
    }

    @GET
    @Path("/")
    public Viewable search(@QueryParam("query") @DefaultValue("") String query){
        List<Article> docs = new ArrayList<Article>();
        if (!"".equals(query)){
            Results<ScoredDocument> scoredDocuments = searchRepository.search(query);
            for (ScoredDocument scoredDocument: scoredDocuments){
                ArticleState articleState = ArticleState.valueOf(scoredDocument.getField("state").iterator().next().getText());
                if (!userPrincipalHolder.get().contains("cm") && ArticleState.PENDING.equals(articleState)){
                    continue;
                }
                Article article = new Article();
                article.setCreated(scoredDocument.getField("created").iterator().next().getDate());
                article.setLastUpdated(scoredDocument.getField("updated").iterator().next().getDate());
                article.setAuthor(scoredDocument.getField("author").iterator().next().getText());
                article.setContent(scoredDocument.getField("content").iterator().next().getHTML());
                article.setFeed(scoredDocument.getField("feed").iterator().next().getText());
                article.setId(Long.parseLong(scoredDocument.getField("id").iterator().next().getText()));
                article.setPermalink(scoredDocument.getId());
                article.setShortContent(scoredDocument.getField("shortContent").iterator().next().getHTML());
                article.setState(articleState);
                article.setTitle(scoredDocument.getField("title").iterator().next().getText());
                docs.add(article);    
            }
        }

        Map<String, Object> model = new HashMap<String, Object>();
        model.put("query",query);
        model.put("results",docs);
        return new Viewable("/search.jsp", model);
    }

}
