package org.guiceae.main.web;

import com.google.appengine.api.blobstore.BlobKey;
import com.google.appengine.api.blobstore.BlobstoreService;
import com.google.appengine.api.blobstore.BlobstoreServiceFactory;
import com.google.appengine.api.images.ImagesService;
import com.google.appengine.api.images.ImagesServiceFactory;
import com.google.inject.Inject;
import org.guiceae.main.model.Album;
import org.guiceae.main.model.Photo;
import org.guiceae.main.repositories.AlbumRepository;
import org.guiceae.main.repositories.PhotoRepository;

import javax.inject.Singleton;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * User: Igor Petruk
 * Date: 27.06.12
 * Time: 1:43
 */
@Singleton
public class UploadServlet extends HttpServlet {
    @Inject
    PhotoRepository photoRepository;
    @Inject
    AlbumRepository albumRepository;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();
        Map<String, List<BlobKey>> blobs = blobstoreService.getUploads(req);
        List<BlobKey> blobKeys = blobs.get("photos");

        ImagesService imagesService = ImagesServiceFactory.getImagesService();
        if (blobKeys != null) {
            List<Photo> photos = new ArrayList<Photo>();
            for (BlobKey key : blobKeys) {
                photos.add(new Photo(imagesService.getServingUrl(key), key.getKeyString()));
            }
            photos = photoRepository.persistPhoto(photos);
            req.setAttribute("newPhotos", photos);

            List<Album> albums = albumRepository.getAll();
            if (albums == null || albums.isEmpty()) {
                Album defaultAlbum = new Album("defaultAlbum", "All photos with unspecified albom");
                albumRepository.persistAlbum(defaultAlbum);
                albums = albumRepository.getAll();
            }
            req.setAttribute("albums", albums);
            getServletConfig().getServletContext().getRequestDispatcher(
                    "/WEB-INF/jsp/introduce-photo.jsp").forward(req, resp);
        } else {
            resp.sendRedirect("/app/index");
        }
    }
}
