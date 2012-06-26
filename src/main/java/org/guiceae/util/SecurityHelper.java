package org.guiceae.util;

import com.google.appengine.api.memcache.MemcacheService;
import com.google.appengine.api.memcache.MemcacheServiceFactory;
import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;
import org.guiceae.util.model.UserRoles;

import javax.inject.Provider;
import javax.persistence.EntityManager;

public class SecurityHelper {
    public static UserRoles getUserRoles(Provider<EntityManager> entityManagerProvider){
        UserService userService = UserServiceFactory.getUserService();
        User user = userService.getCurrentUser();
        if (user!=null){
            MemcacheService memcacheService = MemcacheServiceFactory.getMemcacheService();
            String key = "User"+user.getUserId();
            UserRoles userRoles = (UserRoles)memcacheService.get(key);
            if (userRoles==null){
                EntityManager entityManager = entityManagerProvider.get();
                userRoles = entityManager.find(UserRoles.class, user.getUserId());
                if (userRoles!=null)
                    memcacheService.put(key, userRoles);
            }
            return userRoles;
        }else{
            return null;
        }
    }

}
