package org.guiceae.main.web;

import com.sun.jersey.api.view.Viewable;
import org.guiceae.main.model.UserDetails;
import org.guiceae.main.repositories.UserRepository;
import org.guiceae.util.UserPrincipalHolder;

import javax.annotation.security.RolesAllowed;
import javax.inject.Inject;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import java.util.Collection;
import java.util.List;
import java.util.Set;

@Path("/app/users")
@RolesAllowed("admin")
public class UsersController {
    @Inject
    UserRepository userRepository;

    @Inject
    UserPrincipalHolder userPrincipalHolder;

    @GET
    public Viewable users(){
        return new Viewable("/users.jsp");
    }

    @GET
    @Path("/allUsers")
    @Produces(MediaType.APPLICATION_JSON)
    public Collection<UserDetails> allUsers(){
        return userRepository.getAll();
    }

    @GET
    @Path("/user/{email}")
    @Produces(MediaType.APPLICATION_JSON)
    public UserDetails user(@PathParam("email")String email){
        return userRepository.loadUser(email);
    }

    @DELETE
    @Path("/user/{email}")
    public String userDelete(@PathParam("email")String email){
        userRepository.delete(email);
        return "";
    }

    @GET
    @Path("/rolesCheck")
    @Produces(MediaType.APPLICATION_JSON)
    @RolesAllowed("cm")
    public Collection<String> rolesCheck(){
        return userPrincipalHolder.get();
    }
    
    @POST
    @Path("saveUser/{email}")
    @Consumes(MediaType.APPLICATION_JSON)
    public String saveUser(@PathParam("email")String email, UserDetails userDetails){
        userRepository.saveOrUpdate(email, userDetails);
        return "";
    }
}
