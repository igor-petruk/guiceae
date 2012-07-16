package org.guiceae.main.repositories;

import com.googlecode.objectify.Objectify;
import com.googlecode.objectify.ObjectifyService;
import com.googlecode.objectify.Query;
import org.guiceae.main.model.Article;
import org.guiceae.main.model.ArticleState;
import org.guiceae.main.model.UserQuestion;

import javax.inject.Inject;
import javax.inject.Provider;
import java.util.ArrayList;
import java.util.List;

public class UserQuestionRepository {
    static{
        ObjectifyService.register(UserQuestion.class);
    }

    @Inject
    Provider<Objectify> ofy;

    public void submitQuestion(UserQuestion userQuestion){
        ofy.get().put(userQuestion);
    }

    public int count(String feed, boolean onlyPublished) {
        Query<UserQuestion> query = ofy.get().
                query(UserQuestion.class).
                filter("feed", feed);
        if (onlyPublished) {
            query = query.filter("state", ArticleState.PUBLISHED);
        }
        return query.count();
    }

    public List<UserQuestion> getPendingFeed(String feed) {
        return ofy.get().query(UserQuestion.class)
                .filter("feed",feed)
                .filter("state", ArticleState.PENDING)
                .order("-created")
                .list();
    }

    public List<UserQuestion> getFeed(String feed, boolean onlyPublished, Integer offset) {
        List<UserQuestion> questions = new ArrayList<UserQuestion>();
        if (!onlyPublished && (offset==0)){
            questions.addAll(getPendingFeed(feed));
        }
        Query<UserQuestion> query = ofy.get()
                .query(UserQuestion.class)
                .filter("feed", feed)
                .filter("state", ArticleState.PUBLISHED)
                .order("-created")
                .offset(offset)
                .limit(5);
        questions.addAll(query.list());
        return questions;
    }

}
