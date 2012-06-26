package org.guiceae.main.repositories;

import org.guiceae.main.model.Photo;

import javax.inject.Inject;
import javax.persistence.EntityManager;

/**
 * User: boui
 * Date: 6/26/12
 */

public class PhotoRepository {
    @Inject
    private EntityManager entityManager;

    private String getBlobKeyById(Long id) {
        return entityManager.find(Photo.class, id).getBlobstoreId();
    }

}
