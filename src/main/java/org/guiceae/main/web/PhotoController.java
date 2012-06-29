package org.guiceae.main.web;

import com.google.appengine.api.blobstore.BlobKey;
import com.google.appengine.api.images.ImagesService;
import com.google.appengine.api.images.ImagesServiceFactory;
import com.sun.jersey.api.view.Viewable;
import org.guiceae.main.model.Photo;
import org.guiceae.main.repositories.PhotoRepository;

import javax.inject.Inject;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.ArrayList;
import java.util.List;

/**
 * User: boui
 * Date: 6/26/12
 */
@Path("/app/photo")
public class PhotoController {
    @Inject
    PhotoRepository photoRepository;

    @GET
    @Path("/form")
    public Viewable uploadPage() {
        return new Viewable("/photo.jsp");
    }

    @POST
    @Path("/newPhotos")
    @Consumes(value = {MediaType.APPLICATION_JSON})
    public Response processNewPhotos(Photo info) {
        photoRepository.updatePhotoDescriptions(info);
        return Response.ok().build();
    }

    @GET
    @Path("/albums")
    public Viewable showAlbums() {
        List<Photo> photos = photoRepository.getAll();
        ImagesService imagesService = ImagesServiceFactory.getImagesService();
        List<Photo> tmp = new ArrayList<Photo>();
        for (Photo photo : photos) {
            photo.setServingUrl(imagesService.getServingUrl(new BlobKey(photo.getBlobKey())));
            tmp.add(photo);
        }
        return new Viewable("/album-workshop.jsp", tmp);
    }
}
