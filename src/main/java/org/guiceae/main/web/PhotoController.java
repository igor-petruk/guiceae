package org.guiceae.main.web;

import com.sun.jersey.api.view.Viewable;
import org.guiceae.main.model.Photo;
import org.guiceae.main.repositories.AlbumRepository;
import org.guiceae.main.repositories.PhotoRepository;

import javax.annotation.security.RolesAllowed;
import javax.inject.Inject;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * User: boui
 * Date: 6/26/12
 */
@Path("/app/photo")
public class PhotoController {
    @Inject
    PhotoRepository photoRepository;
    @Inject
    AlbumRepository albumRepository;

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

    @GET
    @Path("/updatePage/{id}")
    @RolesAllowed("cm")
    public Viewable processUpdatePhoto(@PathParam("id") Long id) {
        Map<String, Object> map = new HashMap<String, Object>();
        List<Photo> photos = new ArrayList<Photo>();
        Photo photo = photoRepository.getById(id);
        photos.add(photo);
        map.put("photos", photos);
        map.put("albums", albumRepository.getAll());
        return new Viewable("/update-photo.jsp", map);
    }

    //    it is delete but who cares
    @GET
    @Path("/delete/{id}")
    public Response deleteVideo(@PathParam("id") Long id) throws URISyntaxException {
        photoRepository.deletePhoto(id);
        return Response.seeOther(new URI("/app/album/gallery/photo")).build();
    }

    @GET
    @Path("/admin")
    @RolesAllowed("cm")
    public Viewable getAdminMain() {
        return new Viewable("/add-photo.jsp");
    }
}
