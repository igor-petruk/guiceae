package org.guiceae.main.web;

import com.google.appengine.api.blobstore.BlobKey;
import com.google.appengine.api.blobstore.BlobstoreService;
import com.google.appengine.api.blobstore.BlobstoreServiceFactory;
import com.sun.jersey.api.view.Viewable;
import org.guiceae.main.repositories.AlbumRepository;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.List;
import java.util.Map;

/**
 * User: boui
 * Date: 6/26/12
 */
@Path("/app/photo")
public class PhotoController {
    @Inject
    AlbumRepository albumRepository;

    @GET
    @Path("/form")
    public Viewable uploadPage() {
        return new Viewable("/photo.jsp");
    }
}
