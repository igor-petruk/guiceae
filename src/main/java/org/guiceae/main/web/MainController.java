package org.guiceae.main.web;

import com.sun.jersey.api.view.Viewable;
import org.guiceae.main.repositories.MessageRepository;

import javax.inject.Inject;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import java.util.HashMap;
import java.util.Map;

@Path("/app/index")
public class MainController {
    @Inject
    MessageRepository messageRepository;

    @GET
    public Viewable index() {
        Map<String, Object> model = new HashMap<String, Object>();
        model.put("messages", messageRepository.getAll());
        return new Viewable("/index.jsp", model);
    }

    @GET
    @Path("/main")
    public Viewable getMain() {
        return new Viewable("/main.jsp");
    }
}
