package org.guiceae.util;

import com.google.inject.Injector;

import javax.servlet.http.HttpServletRequest;

/**
 * User: Igor Petruk
 * Date: 27.06.12
 * Time: 0:09
 */
public class JSPInjector {
    public static <T> T get(HttpServletRequest request, Class<? extends T> klass){
        return ((Injector)request.getAttribute("injector")).getInstance(klass);
    }
}
