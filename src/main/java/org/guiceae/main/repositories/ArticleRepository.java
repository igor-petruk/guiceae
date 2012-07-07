package org.guiceae.main.repositories;

import org.guiceae.main.model.Article;
import org.guiceae.main.model.ArticleState;

import javax.inject.Inject;
import javax.persistence.EntityManager;
import javax.persistence.Query;
import javax.persistence.TemporalType;
import java.sql.Timestamp;
import java.text.Normalizer;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Queue;
import java.util.regex.Pattern;

/**
 * User: Igor Petruk
 * Date: 29.06.12
 * Time: 21:49
 */
public class ArticleRepository {
    @Inject
    EntityManager entityManager;

    public Article storeArticle(Article article){
        if (article.getId()!=null){
            entityManager.merge(article);
        }else{
            entityManager.persist(article);
            entityManager.refresh(article);
            if (article.getPermalink()==null || "".equals(article.getPermalink())){
                article.setPermalink(String.valueOf(article.getId()));
            }            
        }
        return article;   
    }
    
    public List<Article> getFeed(String feed, boolean onlyPublished, Date offset){
        Query query = entityManager.createQuery(
                "select a from Article a " +
                        "where (a.feed=:feed) " +
                        "and (a.created<:offset) " +
                        ((onlyPublished)?
                                "and (a.state==:state)":"")+
                        "order by a.created desc");
        query.setParameter("feed",feed);
        query.setParameter("offset",offset);
        if (onlyPublished){
            query.setParameter("state", ArticleState.PUBLISHED);
        }
        query.setMaxResults(10);
        return query.getResultList();
    }
}



