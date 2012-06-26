package org.guiceae.util;

import javax.inject.Inject;
import javax.inject.Provider;
import javax.inject.Singleton;
import javax.persistence.EntityManager;
import javax.servlet.*;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Singleton
public class SecurityFilter implements Filter{
    @Inject
    Provider<EntityManager> entityManagerProvider;

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        request.setAttribute("userRoles", SecurityHelper.getUserRoles(entityManagerProvider));
        try{
            chain.doFilter(request,response);
        }catch (NotAuthorizedException e){
            HttpServletResponse httpServletResponse = (HttpServletResponse)response;
            httpServletResponse.setStatus(HttpServletResponse.SC_FORBIDDEN);
        }
    }

    @Override
    public void destroy() {
    }
}
