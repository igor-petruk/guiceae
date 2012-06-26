package org.guiceae.util;

import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;
import org.aopalliance.intercept.MethodInterceptor;
import org.aopalliance.intercept.MethodInvocation;

import javax.annotation.security.RolesAllowed;
import javax.inject.Provider;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

public class SecurityInterceptor implements MethodInterceptor{
    UserService userService = UserServiceFactory.getUserService();

    Provider<UserPrincipalHolder> userPrincipalHolder;

    public SecurityInterceptor(Provider<UserPrincipalHolder> userPrincipalHolder) {
        this.userPrincipalHolder = userPrincipalHolder;
    }

    @Override
    public Object invoke(MethodInvocation invocation) throws Throwable {
        Set<String> userRoles = userPrincipalHolder.get().get();
        if (userRoles!=null){
            Set<String> rolesAllowed = new HashSet<String>();

            RolesAllowed methodRolesAllowed = invocation.getMethod().getAnnotation(RolesAllowed.class);
            if (methodRolesAllowed!=null)
                rolesAllowed.addAll(Arrays.asList(methodRolesAllowed.value()));

            RolesAllowed classRolesAllowed = invocation.getMethod().getDeclaringClass().getAnnotation(RolesAllowed.class);
            if (classRolesAllowed!=null)
                rolesAllowed.addAll(Arrays.asList(classRolesAllowed.value()));

            for (String role: rolesAllowed){
                if (userRoles.contains(role)){
                    return invocation.proceed();
                }
            }
        }
        throw new NotAuthorizedException();
    }
}
