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
import java.util.*;

/**
 * User: boui
 * Date: 7/3/12
 */
@Path("app/album")
public class AlbumController {

    @Inject
    AlbumRepository albumRepository;
    @Inject
    PhotoRepository photoRepository;

    @GET
    @Path("/all")
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
    @Path("/get/{albumId}")
    @Produces(MediaType.APPLICATION_JSON)
    public Album getAlbumById(@PathParam("albumId") Long albumId) {
        return albumRepository.getById(albumId);
    }

    @GET
    @Path("/new")
    public Viewable newAlbumPage() {
        return new Viewable("/album.jsp");
    }


    @POST
    @Path("/addNew")
    public Response processNewAlbum(@FormParam("title") String title, @FormParam("description") String desc) throws URISyntaxException {
        Album info = new Album(title, desc);
        albumRepository.persistAlbum(info);
        return Response.seeOther(new URI("/app/album/all")).build();
    }

    @GET
    @Path("/gallery")
    public Viewable getGallery() {
        Map<String, List<? extends Object>> map = new HashMap<String, List<? extends Object>>();
        map.put("albums", albumRepository.getAll());
        return new Viewable("/gallery.jsp", map);
    }

    @GET
    @Path("/photos/{albumId}")
    @Produces(MediaType.APPLICATION_JSON)
    public Collection<Photo> getByAlbumId(@PathParam("albumId") Long albumId) {
        return photoRepository.getByAlbumId(albumId);
    }

}
