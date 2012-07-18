package org.guiceae.main.web;

import com.sun.jersey.api.view.Viewable;

import javax.annotation.security.RolesAllowed;
import javax.ws.rs.GET;
import javax.ws.rs.Path;

@Path("/app/index")
public class MainController {
    @GET
    public Viewable getMain() {
        return new Viewable("/main.jsp");
    }

    @GET
    @Path("/admin")
    @RolesAllowed("cm")
    public Viewable getAdminMain() {
        return new Viewable("/adminPage.jsp");
    }
}
