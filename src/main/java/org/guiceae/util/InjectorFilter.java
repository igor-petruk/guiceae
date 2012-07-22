package org.guiceae.util;

import com.google.appengine.api.utils.SystemProperty;
import com.google.inject.Inject;
import com.google.inject.Injector;
import org.guiceae.util.bootstrap.Bootstrap;
import org.guiceae.util.bootstrap.DevelopmentBootstrap;

import javax.inject.Provider;
import javax.inject.Singleton;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.net.URL;

/**
 * User: Igor Petruk
 * Date: 26.06.12
 * Time: 23:39
 */
@Singleton
public class InjectorFilter implements Filter {
    @Inject
    Injector injector;

    @Inject(optional = true)
    @DevelopmentBootstrap
    Provider<Bootstrap> developmentBootstrapProvider;

    boolean bootstrapped = false;

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    private void runBootstrap(){
        if (SystemProperty.environment.value() == SystemProperty.Environment.Value.Development){
            Bootstrap developmentBootstrap = developmentBootstrapProvider.get();
            if (developmentBootstrap!=null){
                developmentBootstrap.bootstrap();
            }
        }
        bootstrapped = true;
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        if (!bootstrapped){
            runBootstrap();
        }
        request.setAttribute("injector", injector);
        String siteUrl = new URL(((HttpServletRequest)request).getRequestURL().toString()).getAuthority();
        request.setAttribute("siteUrl",siteUrl);
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
    }
}
