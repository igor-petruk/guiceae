package org.guiceae.main.repositories;

import com.googlecode.objectify.Key;
import com.googlecode.objectify.Objectify;
import com.googlecode.objectify.ObjectifyService;
import org.guiceae.main.model.Article;
import org.guiceae.main.model.Message;

import javax.inject.Inject;
import javax.inject.Provider;
import java.util.List;

public class MessageRepository {
    static{
        ObjectifyService.register(Message.class);
    }

    @Inject
    Provider<Objectify> ofy;

    public List<Message> getAll() {
        return ofy.get().query(Message.class).list();
    }

    public void create(Message message) {
        ofy.get().put(message);
    }

    public void deleteById(long id) {
        ofy.get().get(Message.class, id);
    }
}
