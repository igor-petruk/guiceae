package org.guiceae.main.web;

import com.sun.jersey.api.view.Viewable;
import org.guiceae.main.model.Article;
import org.guiceae.main.repositories.ArticleRepository;
import org.guiceae.util.UserPrincipalHolder;

import javax.inject.Inject;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import java.sql.Timestamp;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * User: Igor Petruk
 * Date: 29.06.12
 * Time: 22:12
 */
@Path("/app/feed")
public class FeedsController {
    @Inject
    ArticleRepository articleRepository;

    @Inject
    UserPrincipalHolder userPrincipalHolder;

    @GET
    @Path("/{feed}")
    public Viewable givenFeed(@PathParam("feed") String feed, @QueryParam("offset") String offset){
        Date date = new Date();
        if (offset!=null){
            date = new Date(Long.parseLong(offset));
        }
        return produceFeed(feed, date);
    }

    private Viewable produceFeed(String feed, Date offset){
        boolean showPending = userPrincipalHolder.get().contains("cm");
        List<Article> articles = articleRepository.getFeed(feed, !showPending, offset);
        Map<String, Object> it = new HashMap<String, Object>();
        it.put("feed",articles);
        it.put("feedName",feed);
        return new Viewable("/feed.jsp",it);
    }
}
