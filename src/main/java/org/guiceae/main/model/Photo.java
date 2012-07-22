package org.guiceae.main.model;

import org.guiceae.util.Pollable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import java.io.Serializable;

/**
 * User: boui
 * Date: 6/26/12
 */
@Entity
@Pollable
public class Photo implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String title;
    private String blobKey;
    private String servingUrl;
    private String description;
    private Long albumId = 0L;

    public Photo() {
    }

    public Photo(String servingUrl, String blobKey) {
        this.servingUrl = servingUrl;
        this.blobKey = blobKey;
    }

    public String getBlobKey() {
        return blobKey;
    }

    public void setBlobKey(String blobKey) {
        this.blobKey = blobKey;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getServingUrl() {
        return servingUrl;
    }

    public void setServingUrl(String servingUrl) {
        this.servingUrl = servingUrl;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Long getAlbumId() {
        return albumId;
    }

    public void setAlbumId(Long albumId) {
        this.albumId = albumId;
    }

    @Override
    public String toString() {
        return "Photo{ " +
                "id = " + id +
                ", blobstoreKey = '" + blobKey + '\'' +
                ", servingUrl = " + servingUrl + " " +
                '}';
    }
}
