package org.guiceae.main.repositories;

import com.googlecode.objectify.Objectify;
import com.googlecode.objectify.ObjectifyService;
import org.guiceae.main.model.Photo;

import javax.inject.Inject;
import javax.inject.Provider;
import java.util.Collection;
import java.util.List;

/**
 * User: boui
 * Date: 6/26/12
 */

public class PhotoRepository {
    static {
        ObjectifyService.register(Photo.class);
    }

    @Inject
    Provider<Objectify> ofy;

    public void updatePhotoDescriptions(Photo photo) {
        Objectify ofy = this.ofy.get();

        System.out.println();
        System.out.println(photo);
        System.out.println();

        Photo ph = ofy.find(Photo.class, photo.getId());
        if (ph != null) {
            if (!photo.getTitle().equals(ph.getTitle())) {
                ph.setTitle(photo.getTitle());
            }
            if (!photo.getDescription().equals(ph.getDescription())) {
                ph.setDescription(photo.getDescription());
            }
            if (!photo.getAlbumId().equals(ph.getAlbumId())) {
                ph.setAlbumId(photo.getAlbumId());
            }
            ofy.put(ph);
        }
    }

    public List<Photo> persistPhoto(List<Photo> photos) {
        ofy.get().put(photos);
        return photos;
    }

    public void deletePhoto(Photo photo) {
        ofy.get().delete(Photo.class, photo.getId());
    }

    public List<Photo> getAll() {
        return ofy.get().query(Photo.class).list();
    }

    public Collection<Photo> getByAlbumId(Long albumId) {
        Collection<Photo> photos = ofy.get().query(Photo.class).list();
        return photos;
    }
}
