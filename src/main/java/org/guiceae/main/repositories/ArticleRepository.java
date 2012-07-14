package org.guiceae.main.repositories;

import com.googlecode.objectify.Objectify;
import com.googlecode.objectify.ObjectifyService;
import com.googlecode.objectify.Query;
import org.guiceae.main.model.Article;
import org.guiceae.main.model.ArticleState;

import javax.inject.Inject;
import javax.inject.Provider;
import java.util.Date;
import java.util.List;

/**
 * User: Igor Petruk
 * Date: 29.06.12
 * Time: 21:49
 */
public class ArticleRepository {
    static {
        ObjectifyService.register(Article.class);
    }

    @Inject
    Provider<Objectify> ofy;

    public Article storeArticle(Article article) {
        Objectify ofy = ObjectifyService.beginTransaction();
        try {
            ofy.put(article);
            if (article.getPermalink() == null || "".equals(article.getPermalink())) {
                article.setPermalink(String.valueOf(article.getId()));
                ofy.put(article);
            }
            return article;
        } finally {
            ofy.getTxn().commit();
        }
    }

    public void publish(Long id){
        Article article = getArticle(id);
        article.setState(ArticleState.PUBLISHED);
        storeArticle(article);
    }

    public Article getArticle(Long id){
        return ofy.get().get(Article.class, id);
    }

    public void delete(Long id) {
        ofy.get().delete(Article.class, id);
    }

    public List<Article> getFeed(String feed, boolean onlyPublished, Date offset, Integer number) {
        Query<Article> query = ofy.get().
                query(Article.class).
                filter("feed", feed).
                filter("created <", offset);
        if (onlyPublished) {
            query = query.filter("state", ArticleState.PUBLISHED);
        }
        return query.limit(number).list();
    }

    public List<Article> getFeed(String feed, boolean onlyPublished, Date offset) {
        return getFeed(feed, onlyPublished, offset, 10);
    }

    public void mergeArticle(Article article) {
        if (article.getId() == null || article.getId() == 0) {
            article.setId(null);
            ofy.get().put(article);
        } else {
            Objectify ofy = this.ofy.get();
            Article oldArticle = ofy.get(Article.class, article.getId());
            oldArticle.setLastUpdated(new Date());
            oldArticle.setContent(article.getContent());
            oldArticle.setFeed(article.getFeed());
            oldArticle.setTitle(article.getTitle());
            oldArticle.setPermalink(article.getPermalink());
            ofy.put(oldArticle);
        }
    }
}



