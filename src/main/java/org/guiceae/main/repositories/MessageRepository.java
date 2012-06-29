package org.guiceae.main.repositories;

import com.google.inject.persist.Transactional;
import org.guiceae.main.model.Message;

import javax.inject.Inject;
import javax.persistence.EntityManager;
import java.util.List;

@Transactional
public class MessageRepository {

    @Inject
    private EntityManager entityManager;

    public List<Message> getAll() {
        return entityManager.createQuery("select m from Message m").getResultList();
    }

    public void create(Message message) {
        /* User user = UserServiceFactory.getUserService().getCurrentUser();
        UserRoles roles = new UserRoles();
        roles.setUserId(user.getUserId());
        roles.getRoles().add("admin");
        entityManager.persist(roles);*/
        entityManager.persist(message);
        //entityManager.getTransaction().commit();
        //entityManager.getTransaction().begin();
        //System.out.println(Arrays.toString(getAll().toArray()));
    }

    public void deleteById(long id) {
        entityManager.remove(entityManager.find(Message.class, id));
    }
}
