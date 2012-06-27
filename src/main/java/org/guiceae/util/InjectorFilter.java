package org.guiceae.util;

import com.google.appengine.api.utils.SystemProperty;
import com.google.inject.Inject;
import com.google.inject.Injector;
import com.google.inject.persist.UnitOfWork;
import org.guiceae.util.bootstrap.Bootstrap;
import org.guiceae.util.bootstrap.DevelopmentBootstrap;

import javax.inject.Provider;
import javax.inject.Singleton;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.servlet.*;
import java.io.IOException;

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

    @Inject
    EntityManagerFactory entityManagerFactory;

    boolean bootstrapped = false;

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    private void runBootstrap(){
        if (SystemProperty.environment.value() == SystemProperty.Environment.Value.Development){
            Bootstrap developmentBootstrap = developmentBootstrapProvider.get();
            if (developmentBootstrap!=null){
                EntityManager entityManager = null;
                try{
                    entityManager = entityManagerFactory.createEntityManager();
                    developmentBootstrap.bootstrap(entityManager);
                }finally {
                    entityManager.close();
                }
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
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
    }
}
