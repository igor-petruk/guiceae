package org.guiceae.main.web;

import com.sun.jersey.api.view.Viewable;
import org.guiceae.util.model.UserRoles;

import javax.annotation.security.RolesAllowed;
import javax.inject.Inject;
import javax.persistence.EntityManager;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import java.util.List;

@Path("/app/users")
@RolesAllowed("admin")
public class UsersController {
    @Inject
    EntityManager entityManager;

    @GET
    @Path("/")
    public Viewable users(){
        List<UserRoles> userRoles = entityManager.createQuery("select u from UserRoles u").getResultList();
        return new Viewable("/users.jsp",userRoles);
    }
}
