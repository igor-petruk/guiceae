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
    public Viewable index(){
        Map<String,Object> model = new HashMap<String, Object>();
        model.put("messages",messageRepository.getAll());
        return new Viewable("/index.jsp",model);
    }

}
