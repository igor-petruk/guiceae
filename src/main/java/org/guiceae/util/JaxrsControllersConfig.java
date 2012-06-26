package org.guiceae.util;

import com.google.inject.Binding;
import com.google.inject.Injector;
import com.google.inject.Key;
import org.guiceae.main.web.MainController;
import org.guiceae.main.web.UsersController;

import javax.inject.Inject;
import javax.inject.Singleton;
import javax.ws.rs.Path;
import javax.ws.rs.core.Application;
import java.util.HashSet;
import java.util.Set;

@Singleton
public class JaxrsControllersConfig extends Application {
    Set<Class<?>> controllers = new HashSet<Class<?>>();

    @Inject
    public JaxrsControllersConfig(Injector injector){
        for (Key key: injector.getAllBindings().keySet()){
            Class klass = key.getTypeLiteral().getRawType();
            Path path = (Path)klass.getAnnotation(Path.class);
            if (path!=null){
                controllers.add(klass);
            }
        }
    }
    
    public Set<Class<?>> getClasses() {
        return controllers;
    }


}
