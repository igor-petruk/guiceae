package org.guiceae.main.repositories;

import com.googlecode.objectify.Objectify;
import com.googlecode.objectify.ObjectifyService;
import org.guiceae.main.model.Video;

import javax.inject.Inject;
import javax.inject.Provider;
import java.util.List;

/**
 * User: boui
 * Date: 8/7/12
 */

public class VideoRepository {
    @Inject
    private Provider<Objectify> ofy;

    static{
        ObjectifyService.register(Video.class);
    }

    public Video getById(Long id) {
        return ofy.get().get(Video.class, id);
    }

    public void mergeVideo(Video video) {
        if (video.getId() == null) {
            ofy.get().put(video);
        } else {
            Objectify ofy = this.ofy.get();
            Video oldVideo = getById(video.getId());
            oldVideo.setDescription(video.getDescription());
            oldVideo.setYoutubeUrl(video.getYoutubeUrl());
            oldVideo.setTitle(video.getTitle());
            ofy.put(oldVideo);
        }
    }

    public void deleteById(Long id) {
        Objectify ofy = this.ofy.get();
        Video video = ofy.get(Video.class, id);
        ofy.delete(Video.class, id);
    }

    public List<Video> getVideoAlbum() {
        return ofy.get().query(Video.class).list();
    }

}
