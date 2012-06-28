package org.guiceae.main.repositories;

import com.google.appengine.api.memcache.MemcacheService;
import com.google.appengine.api.memcache.MemcacheServiceFactory;
import com.google.inject.persist.Transactional;
import org.guiceae.main.model.UserDetails;
import org.guiceae.util.UserPrincipalProvider;
import javax.inject.Inject;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import java.util.Collection;

/**
 * User: Igor Petruk
 * Date: 26.06.12
 * Time: 23:23
 */
public class UserRepository implements UserPrincipalProvider{
    @Inject
    EntityManager entityManager;

    @Inject
    EntityManagerFactory entityManagerFactory;

    @Override
    public UserDetails loadUser(String userId) {
        MemcacheService memcacheService = MemcacheServiceFactory.getMemcacheService();
        if (userId==null){
            return null;
        }
        String key = "User"+userId;
        UserDetails userDetails = (UserDetails)memcacheService.get(key);
        if (userDetails==null){
            System.out.println("USER ID:" +userId);
            userDetails = entityManager.find(UserDetails.class, userId);
            if (userDetails!=null)
                memcacheService.put(key, userDetails);
        }
        return userDetails;
    }

    public void delete(String email){
        UserDetails oldUser = entityManager.find(UserDetails.class, email);
        if (oldUser!=null){
            entityManager.remove(oldUser);
        }
        invalidateCache(email);
    }
    
    private void invalidateCache(String email){
        String key = "User"+email;
        MemcacheService memcacheService = MemcacheServiceFactory.getMemcacheService();
        memcacheService.delete(key);
    }

    public void saveOrUpdate(String email, UserDetails userDetails){
        invalidateCache(email);
        if (email.equals(userDetails.getEmail())){
            UserDetails old = entityManager.find(UserDetails.class, email);
            if (old!=null){
                old.getRoles().clear();
                old.getRoles().addAll(userDetails.getRoles());
                entityManager.merge(old);
            }else{
                entityManager.persist(userDetails);
            }
        }else{
            delete(email);
            entityManager.persist(userDetails);
        }
    }

    public Collection<UserDetails> getAll(){
        return entityManager.createQuery("select u from UserDetails u").getResultList();
    }
}
