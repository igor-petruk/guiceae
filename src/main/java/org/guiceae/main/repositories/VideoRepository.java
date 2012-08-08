package org.guiceae.main.repositories;

import com.googlecode.objectify.Objectify;
import org.guiceae.main.model.Video;

import javax.inject.Inject;
import javax.inject.Provider;

/**
 * User: boui
 * Date: 8/7/12
 */

public class VideoRepository {
    @Inject
    private Provider<Objectify> ofy;


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
}
