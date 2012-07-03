package org.guiceae.main.web;

import com.google.appengine.api.blobstore.BlobKey;
import com.google.appengine.api.images.ImagesService;
import com.google.appengine.api.images.ImagesServiceFactory;
import com.sun.jersey.api.view.Viewable;
import org.guiceae.main.model.Album;
import org.guiceae.main.model.Photo;
import org.guiceae.main.repositories.AlbumRepository;
import org.guiceae.main.repositories.PhotoRepository;

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
    @Path("/newPhoto")
    public Viewable uploadPage() {
        return new Viewable("/photo.jsp");
    }

    @POST
    @Path("/updatePhoto")
    @Consumes(value = {MediaType.APPLICATION_JSON})
    public Response processNewPhotos(Photo info) {
        photoRepository.updatePhotoDescriptions(info);
        return Response.ok().build();
    }

    @GET
    @Path("/deletePhoto")
    public Response processDeletePhoto(Photo info) {
        photoRepository.deletePhoto(info);
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
        List<Album> albums = albumRepository.getAll();
        Map<String, List<? extends Object>> map = new HashMap<String, List<? extends Object>>();
        map.put("albums", albums);
        map.put("photos", tmp);
        return new Viewable("/album-workshop.jsp", map);
    }

    @GET
    @Path("/newAlbumPage")
    public Viewable newAlbumPage() {
        return new Viewable("/album.jsp");
    }


    @POST
    @Path("/newAlbum")
    public Response processNewAlbum(@FormParam("title") String title, @FormParam("description") String desc) throws URISyntaxException {
        Album info = new Album(title, desc);
        albumRepository.persistAlbum(info);
        return Response.seeOther(new URI("/app/photo/albums")).build();
    }


}
