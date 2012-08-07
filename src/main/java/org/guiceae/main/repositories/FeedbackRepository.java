package org.guiceae.main.repositories;

import com.googlecode.objectify.Objectify;
import com.googlecode.objectify.ObjectifyService;
import com.googlecode.objectify.Query;
import org.guiceae.main.model.ArticleState;
import org.guiceae.main.model.Feedback;
import org.guiceae.main.model.FeedbackFeedType;

import javax.inject.Inject;
import javax.inject.Provider;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class FeedbackRepository {
    static {
        ObjectifyService.register(Feedback.class);
    }

    @Inject
    Provider<Objectify> ofy;

    public void submitQuestion(Feedback feedback) {
        ofy.get().put(feedback);
    }

    public Feedback getFeedback(Long id) {
        return ofy.get().get(Feedback.class, id);
    }

    public int count(FeedbackFeedType feed, boolean onlyPublished) {
        Query<Feedback> query = ofy.get().
                query(Feedback.class).
                filter("feed", feed);
        if (onlyPublished) {
            query = query.filter("state", ArticleState.PUBLISHED);
        }
        return query.count();
    }

    public List<Feedback> getPendingFeed(FeedbackFeedType feed) {
        return ofy.get().query(Feedback.class)
                .filter("feed", feed)
                .filter("state", ArticleState.PENDING)
                .order("-created")
                .list();
    }

    public List<Feedback> getFeed(FeedbackFeedType feed, boolean onlyPublished, Integer offset) {
        return getFeed(feed, onlyPublished, offset, 5);
    }

    public List<Feedback> getFeed(FeedbackFeedType feed, boolean onlyPublished, Integer offset, Integer limit) {
        List<Feedback> questions = new ArrayList<Feedback>();
        if (!onlyPublished && (offset == 0)) {
            questions.addAll(getPendingFeed(feed));
        }
        Query<Feedback> query = ofy.get()
                .query(Feedback.class)
                .filter("feed", feed)
                .filter("state", ArticleState.PUBLISHED)
                .order("-created")
                .offset(offset)
                .limit(limit);
        questions.addAll(query.list());
        return questions;
    }

    public void publish(Long id) {
        Objectify ofy = this.ofy.get();
        Feedback feedback = ofy.get(Feedback.class, id);
        feedback.setState(ArticleState.PUBLISHED);
        ofy.put(feedback);
    }

    public void delete(Long id) {
        ofy.get().delete(Feedback.class, id);
    }
}
