package org.guiceae.main.web;

import com.sun.jersey.api.view.Viewable;
import org.guiceae.main.model.Message;
import org.guiceae.main.repositories.MessageRepository;

import javax.inject.Inject;
import javax.ws.rs.*;
import javax.ws.rs.core.Response;
import java.net.*;
import java.util.*;

@Path("/app/index")
public class MainController {
    @Inject
    MessageRepository messageRepository;

    @GET
    @Path("/")
    public Viewable index(){
        Map<String,Object> model = new HashMap<String, Object>();
        model.put("messages",messageRepository.getAll());
        return new Viewable("/index.jsp",model);
    }

    @GET
    @Path("/deleteitem/{id}")
    public Response delete(@PathParam("id") Integer id) throws URISyntaxException{
        messageRepository.deleteById(id);
        return Response.seeOther(new URI("/app/index")).build();
    }

    @POST
    @Path("/addmessage")
    public Response addMessage(@FormParam("text") String text) throws URISyntaxException{
        messageRepository.create(new Message(text));
        return Response.seeOther(new URI("/app/index")).build();
    }
}
