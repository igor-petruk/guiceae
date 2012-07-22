package org.guiceae.main.web;

import com.google.appengine.api.blobstore.BlobKey;
import com.google.appengine.api.blobstore.BlobstoreService;
import com.google.appengine.api.blobstore.BlobstoreServiceFactory;
import com.google.appengine.api.images.ImagesService;
import com.google.appengine.api.images.ImagesServiceFactory;
import com.google.appengine.api.images.ServingUrlOptions;
import com.google.common.base.Preconditions;
import com.google.common.collect.ImmutableList;
import com.google.inject.Inject;
import org.codehaus.jackson.map.ObjectMapper;
import org.guiceae.main.model.Album;
import org.guiceae.main.model.Photo;
import org.guiceae.main.repositories.AlbumRepository;
import org.guiceae.main.repositories.PhotoRepository;

import javax.annotation.security.RolesAllowed;
import javax.inject.Singleton;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

class PhotoInfo{
    Long id;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }
}

@Singleton
public class CkUploadServlet  extends HttpServlet {
    @Inject
    PhotoRepository photoRepository;
    @Inject
    AlbumRepository albumRepository;

    @Override
    @RolesAllowed("cm")
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();
        Map<String, List<BlobKey>> blobs = blobstoreService.getUploads(req);
        List<BlobKey> blobKeys = blobs.get("qqfile");
        Preconditions.checkArgument(blobKeys.size()==1);
        resp.setContentType("text/html");

        ImagesService imagesService = ImagesServiceFactory.getImagesService();
        if (blobKeys != null) {

            BlobKey key = blobKeys.get(0);
            Photo photo = new Photo(imagesService.getServingUrl(ServingUrlOptions.Builder.withBlobKey(key)),
                    key.getKeyString()); 
            photo = photoRepository.persistPhoto(ImmutableList.of(photo)).get(0);
            ObjectMapper objectMapper = new ObjectMapper();
            PhotoInfo photoInfo = new PhotoInfo();
            photoInfo.setId(photo.getId());
            objectMapper.writeValue(resp.getOutputStream(), photoInfo);
        } else {
            resp.setStatus(500);
        }
    }

}
