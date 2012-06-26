package org.guiceae.util;

import javax.inject.Singleton;
import java.util.Set;

/**
 * User: Igor Petruk
 * Date: 26.06.12
 * Time: 23:46
 */
@Singleton
public class UserPrincipalHolder {
    ThreadLocal<Set<String>> userPrincipalThreadLocal = new ThreadLocal<Set<String>>();
    
    public Set<String> get(){
        return userPrincipalThreadLocal.get();
    }
    
    public void set(Set<String> userPrincipal){
        userPrincipalThreadLocal.set(userPrincipal);
    }
}
