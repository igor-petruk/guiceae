package org.guiceae.main.repositories;

import org.guiceae.main.model.Photo;

import javax.inject.Inject;
import javax.persistence.EntityManager;
import java.util.ArrayList;
import java.util.List;

/**
 * User: boui
 * Date: 6/26/12
 */

public class PhotoRepository {
    @Inject
    private EntityManager entityManager;

    public void updatePhotoDescriptions(Photo photo) {

        Photo ph = entityManager.find(Photo.class, photo.getId());
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
            entityManager.merge(ph);
        }
    }

    public List<Photo> persistPhoto(List<Photo> photos) {
        List<Photo> list = new ArrayList<Photo>();
        for (Photo photo : photos) {
            entityManager.persist(photo);
            entityManager.refresh(photo);
            list.add(photo);
        }
        return list;
    }

    public List<Photo> getAll() {
        return entityManager.createQuery("select p from Photo p").getResultList();
    }
}
