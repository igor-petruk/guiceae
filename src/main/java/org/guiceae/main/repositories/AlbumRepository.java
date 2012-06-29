package org.guiceae.main.repositories;

import org.guiceae.main.model.Album;

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

    public List<Album> getAll() {
        return entityManager.createQuery("select a from Album a").getResultList();
    }

    public void persistAlbum(Album album) {
        entityManager.persist(album);
        entityManager.refresh(album);
    }
}
