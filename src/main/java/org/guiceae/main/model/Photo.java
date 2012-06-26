package org.guiceae.main.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import java.io.Serializable;

/**
 * User: boui
 * Date: 6/26/12
 */
@Entity
public class Photo implements Serializable {
    @Id
    @GeneratedValue
    private Long id;
    private String blobstoreId;
    private String description;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getBlobstoreId() {
        return blobstoreId;
    }

    public void setBlobstoreId(String blobstoreId) {
        this.blobstoreId = blobstoreId;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Override
    public String toString() {
        return "Photo{" +
                "id=" + id +
                ", blobstoreId='" + blobstoreId + '\'' +
                '}';
    }
}
