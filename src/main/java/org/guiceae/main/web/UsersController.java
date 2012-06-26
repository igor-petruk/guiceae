package org.guiceae.main.web;

import com.sun.jersey.api.view.Viewable;
import org.guiceae.main.model.UserDetails;
import org.guiceae.main.repositories.UserRepository;

import javax.annotation.security.RolesAllowed;
import javax.inject.Inject;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import java.util.Collection;

@Path("/app/users")
@RolesAllowed("admin")
public class UsersController {
    @Inject
    UserRepository userRepository;

    @GET
    @Path("/")
    public Viewable users(){
        Collection<UserDetails> userDetailsList = userRepository.getAll();
        return new Viewable("/users.jsp",userDetailsList);
    }
}
