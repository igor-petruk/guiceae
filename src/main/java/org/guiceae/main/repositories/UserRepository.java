package org.guiceae.main.repositories;

import com.google.appengine.api.memcache.MemcacheService;
import com.google.appengine.api.memcache.MemcacheServiceFactory;
import com.googlecode.objectify.Objectify;
import com.googlecode.objectify.ObjectifyService;
import org.guiceae.main.model.UserDetails;
import org.guiceae.util.UserPrincipalProvider;
import javax.inject.Inject;
import javax.inject.Provider;
import java.util.Collection;

/**
 * User: Igor Petruk
 * Date: 26.06.12
 * Time: 23:23
 */
public class UserRepository implements UserPrincipalProvider{
    static{
        ObjectifyService.register(UserDetails.class);
    }

    @Inject
    Provider<Objectify> ofy;

    @Override
    public UserDetails loadUser(String userId) {
        userId = userId.toLowerCase();
/*        MemcacheService memcacheService = MemcacheServiceFactory.getMemcacheService();
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
        return userDetails;*/

        return ofy.get().find(UserDetails.class, userId);
    }

    public void delete(String email){
        email = email.toLowerCase();
/*        UserDetails oldUser = entityManager.find(UserDetails.class, email);
        if (oldUser!=null){
            entityManager.remove(oldUser);
        }
        invalidateCache(email);*/
        ofy.get().delete(UserDetails.class, email);
    }
    
    private void invalidateCache(String email){
        String key = "User"+email.toLowerCase();
        MemcacheService memcacheService = MemcacheServiceFactory.getMemcacheService();
        memcacheService.delete(key);
    }

    public void save(UserDetails userDetails){
        ofy.get().put(userDetails);
    }

    public void saveOrUpdate(String email, UserDetails userDetails){
        Objectify ofy = this.ofy.get();
        email = email.toLowerCase();
        userDetails.setEmail(userDetails.getEmail().toLowerCase());
        //invalidateCache(email);
        if (email.equals(userDetails.getEmail())){
            UserDetails old = ofy.find(UserDetails.class, email);
            if (old!=null){
                old.getRoles().clear();
                old.getRoles().addAll(userDetails.getRoles());
                ofy.put(old);
            }else{
                ofy.put(userDetails);
            }
        }else{
            delete(email);
            ofy.put(userDetails);
        }
    }

    public Collection<UserDetails> getAll(){
        return ofy.get().query(UserDetails.class).list();
    }
}
