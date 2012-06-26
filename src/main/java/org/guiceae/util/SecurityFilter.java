package org.guiceae.util;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

import javax.inject.Inject;
import javax.inject.Provider;
import javax.inject.Singleton;
import javax.persistence.EntityManager;
import javax.servlet.*;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashSet;
import java.util.Set;

@Singleton
public class SecurityFilter implements Filter{
    @Inject
    Provider<UserPrincipalProvider> userPrincipalProvider;

    @Inject
    UserPrincipalHolder userPrincipalHolder;

    UserService userService = UserServiceFactory.getUserService();

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        Set<String> roles = new HashSet<String>();
        User user = userService.getCurrentUser();
        if (user!=null){
            if (userService.isUserAdmin()){
                roles.add("admin");
            }
            UserPrincipal userPrincipal = userPrincipalProvider.get().loadUser(user.getUserId());
            if (userPrincipal!=null){
                roles.addAll(userPrincipal.getRoles());
            }
        }
        userPrincipalHolder.set(roles);
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
