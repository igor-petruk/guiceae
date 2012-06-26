package org.guiceae.main.repositories;

import org.guiceae.main.model.Album;
import org.guiceae.main.model.Photo;

import javax.inject.Inject;
import javax.persistence.EntityManager;
import java.util.List;

/**
 * User: boui
 * Date: 6/26/12
 */
public class AlbumRepository {
    @Inject
    private EntityManager entityManager;

    public Album getAlbumById(Long id) {
        return entityManager.find(Album.class, id);
    }

    public void persistAlbum(List<Photo> photos) {
        for (Photo photo : photos) {
            entityManager.persist(photo);
        }
    }

}
