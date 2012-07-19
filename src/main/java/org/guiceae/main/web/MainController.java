package org.guiceae.main.web;

import com.google.inject.Inject;
import com.sun.jersey.api.view.Viewable;
import org.guiceae.main.model.Article;
import org.guiceae.main.repositories.ArticleRepository;

import javax.annotation.security.RolesAllowed;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Path("/app/index")
public class MainController {
    @Inject
    ArticleRepository articleRepository;

    @GET
    public Viewable getMain() {
        Map<String, List<? extends Article>> it = new HashMap<String, List<? extends Article>>();
        it.put("newsFeed", articleRepository.getFeed("news", true, 0));
        it.put("charityFeed", articleRepository.getFeed("charity", true, 0));
        return new Viewable("/main.jsp", it);
    }

    @GET
    @Path("/admin")
    @RolesAllowed("cm")
    public Viewable getAdminMain() {
        return new Viewable("/adminPage.jsp");
    }
}
