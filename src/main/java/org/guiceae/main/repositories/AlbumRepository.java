package org.guiceae.main.repositories;

import com.googlecode.objectify.Objectify;
import com.googlecode.objectify.ObjectifyService;
import org.guiceae.main.model.Album;

import javax.inject.Inject;
import javax.inject.Provider;
import java.util.List;

/**
 * User: boui
 * Date: 6/26/12
 */
public class AlbumRepository {
    @Inject
    private Provider<Objectify> ofy;

    static{
        ObjectifyService.register(Album.class);
    }

    public List<Album> getAll() {
        return ofy.get().query(Album.class).list();
    }

    public void persistAlbum(Album album) {
        ofy.get().put(album);
    }
}
