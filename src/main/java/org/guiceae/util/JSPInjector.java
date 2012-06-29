package org.guiceae.util;

import com.google.inject.Injector;
import com.google.inject.Key;

import javax.inject.Inject;
import javax.inject.Named;
import javax.servlet.http.HttpServletRequest;
import java.lang.annotation.Annotation;

/**
 * User: Igor Petruk
 * Date: 27.06.12
 * Time: 0:09
 */
public class JSPInjector {
    private static Injector injector(HttpServletRequest request){
        return ((Injector)request.getAttribute("injector"));
    }

    public static <T> T get(HttpServletRequest request, Class<? extends T> klass){
        return injector(request).getInstance(klass);
    }
    public static <T> T get(HttpServletRequest request, Key<? extends T> key){
        return injector(request).getInstance(key);
    }
    
    public static String getProperty(HttpServletRequest request, final String name){
        return injector(request).getInstance(Key.get(String.class, new Named(){
            @Override
            public String value() {
                return name;
            }

            @Override
            public Class<? extends Annotation> annotationType() {
                return Named.class;
            }
        }));
    }
}
