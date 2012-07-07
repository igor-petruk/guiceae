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
        /* User user = UserServiceFactory.getUserService().getCurrentUser();
        UserRoles roles = new UserRoles();
        roles.setUserId(user.getUserId());
        roles.getRoles().add("admin");
        entityManager.persist(roles);*/
        ofy.get().put(message);
        //entityManager.getTransaction().commit();
        //entityManager.getTransaction().begin();
        //System.out.println(Arrays.toString(getAll().toArray()));
    }

    public void deleteById(long id) {
        ofy.get().get(Message.class, id);
    }
}
