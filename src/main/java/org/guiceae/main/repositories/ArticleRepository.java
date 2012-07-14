package org.guiceae.main.repositories;

import com.google.appengine.api.datastore.Transaction;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;
import com.googlecode.objectify.Objectify;
import com.googlecode.objectify.ObjectifyService;
import com.googlecode.objectify.Query;
import org.guiceae.main.model.Article;
import org.guiceae.main.model.ArticleState;
import org.guiceae.util.UserPrincipalHolder;

import javax.inject.Inject;
import javax.inject.Provider;
import javax.ws.rs.WebApplicationException;
import javax.ws.rs.core.Response;
import java.util.Date;
import java.util.List;

/**
 * User: Igor Petruk
 * Date: 29.06.12
 * Time: 21:49
 */
public class ArticleRepository {
    static{
        ObjectifyService.register(Article.class);
    }

    @Inject
    Provider<Objectify> ofy;

    @Inject
    UserPrincipalHolder userPrincipalHolder;

    public Article storeArticle(Article article){
        Objectify ofy = ObjectifyService.beginTransaction();
        try{
            ofy.put(article);
            if (article.getPermalink()==null || "".equals(article.getPermalink())){
                article.setPermalink(String.valueOf(article.getId()));
                ofy.put(article);
            }
            return article;
        }finally {
            ofy.getTxn().commit();
        }
    }

    public void publish(Long id){
        Article article = getArticle(id);
        article.setState(ArticleState.PUBLISHED);
        article.setAuthor(UserServiceFactory.getUserService().getCurrentUser().getNickname());
        article.setCreated(new Date());
        article.setLastUpdated(new Date());
        storeArticle(article);
    }

    public Article getArticle(Long id){
        return ofy.get().get(Article.class, id);
    }

    public Article getArticleByPermalink(String permalink){
        List<Article> strings = ofy.get().query(Article.class).filter("permalink",permalink).list();
        if (strings.isEmpty()){
            throw new WebApplicationException(Response.Status.NOT_FOUND);
        }else if (strings.size()==1){
            return strings.get(0);
        }else {
            throw new WebApplicationException(Response.Status.INTERNAL_SERVER_ERROR);
        }
    }

    public void delete(Long id){
        ofy.get().delete(Article.class, id);
    }
    
    public List<Article> getFeed(String feed, boolean onlyPublished, Date offset){
        Query<Article> query = ofy.get().
                query(Article.class).
                filter("feed",feed).
                filter("created <",offset);
        if (onlyPublished){
            query = query.filter("state", ArticleState.PUBLISHED);
        }
        return query.limit(10).list();
    }

    public void mergeArticle(Article article){
        if (article.getId()==null || article.getId()==0){
            article.setId(null);
            article.setLastUpdated(new Date());
            ofy.get().put(article);
        }else{
            Objectify ofy = this.ofy.get();
            Article oldArticle = ofy.get(Article.class, article.getId());
            oldArticle.setLastUpdated(new Date());
            oldArticle.setContent(article.getContent());
            oldArticle.setShortContent(article.getShortContent());
            oldArticle.setFeed(article.getFeed());
            oldArticle.setTitle(article.getTitle());
            oldArticle.setPermalink(article.getPermalink());
            ofy.put(oldArticle);
        }
    }
}



