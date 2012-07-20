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
        List<BlobKey> blobKeys = blobs.get("photos");
        Preconditions.checkArgument(blobKeys.size()==1);
        
        ImagesService imagesService = ImagesServiceFactory.getImagesService();
        if (blobKeys != null) {

            BlobKey key = blobKeys.get(0);
            Photo photo = new Photo(imagesService.getServingUrl(ServingUrlOptions.Builder.withBlobKey(key)),
                    key.getKeyString()); 
            photo = photoRepository.persistPhoto(ImmutableList.of(photo)).get(0);
            try {
                Thread.sleep(2000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            resp.sendRedirect("/app/album/browse/0"
                    +"?mode="+req.getParameter("mode")
                    +"&CKEditorFuncNum="+req.getParameter("CKEditorFuncNum"));
        } else {
            resp.sendRedirect("/app/index");
        }
    }

}
