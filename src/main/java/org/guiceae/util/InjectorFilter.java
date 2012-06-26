package org.guiceae.util;

import com.google.inject.Injector;

import javax.inject.Inject;
import javax.inject.Singleton;
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

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        request.setAttribute("injector", injector);
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
    }
}
