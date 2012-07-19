package org.guiceae.main.web;

import com.sun.jersey.api.view.Viewable;
import org.guiceae.main.model.Photo;
import org.guiceae.main.repositories.PhotoRepository;

import javax.annotation.security.RolesAllowed;
import javax.inject.Inject;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

/**
 * User: boui
 * Date: 6/26/12
 */
@Path("/app/photo")
public class PhotoController {
    @Inject
    PhotoRepository photoRepository;


    @GET
    @Path("/new")
    @RolesAllowed("cm")
    public Viewable uploadPage() {
        return new Viewable("/photo.jsp");
    }

    @POST
    @Path("/update")
    @Consumes(value = {MediaType.APPLICATION_JSON})
    @RolesAllowed("cm")
    public Response processNewPhotos(Photo info) {
        photoRepository.updatePhotoDescriptions(info);
        return Response.ok().build();
    }
}
