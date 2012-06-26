package org.guiceae.main.repositories;

import com.google.appengine.api.memcache.MemcacheService;
import com.google.appengine.api.memcache.MemcacheServiceFactory;
import com.google.inject.persist.Transactional;
import org.guiceae.main.model.UserDetails;
import org.guiceae.util.UserPrincipalProvider;
import javax.inject.Inject;
import javax.persistence.EntityManager;
import java.util.Collection;

/**
 * User: Igor Petruk
 * Date: 26.06.12
 * Time: 23:23
 */
@Transactional
public class UserRepository implements UserPrincipalProvider{
    @Inject
    EntityManager entityManager;

    MemcacheService memcacheService = MemcacheServiceFactory.getMemcacheService();

    @Override
    public UserDetails loadUser(String userId) {
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

    public Collection<UserDetails> getAll(){
        return entityManager.createQuery("select u from UserDetails u").getResultList();
    }
}
