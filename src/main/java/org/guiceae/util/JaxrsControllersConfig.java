package org.guiceae.util;

import org.guiceae.main.web.MainController;
import org.guiceae.main.web.UsersController;

import javax.ws.rs.core.Application;
import java.util.HashSet;
import java.util.Set;

public class JaxrsControllersConfig extends Application {
    public Set<Class<?>> getClasses() {
        Set<Class<?>> s = new HashSet<Class<?>>();
        s.add(MainController.class);
        s.add(UsersController.class);
        return s;
    }


}
