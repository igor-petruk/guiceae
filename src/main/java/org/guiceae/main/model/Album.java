package org.guiceae.main.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import java.io.Serializable;
import java.util.List;

/**
 * User: boui
 * Date: 6/26/12
 */
@Entity
public class Album implements Serializable {
    @Id
    @GeneratedValue
    private Long id;

    @OneToMany
    List<Photo> albom;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public List<Photo> getAlbom() {
        return albom;
    }

    public void setAlbom(List<Photo> albom) {
        this.albom = albom;
    }

}
