package org.guiceae.util;

import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;
import org.aopalliance.intercept.MethodInterceptor;
import org.aopalliance.intercept.MethodInvocation;
import org.guiceae.util.model.UserRoles;

import javax.annotation.security.RolesAllowed;
import javax.inject.Provider;
import javax.persistence.EntityManager;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

public class SecurityInterceptor implements MethodInterceptor{
    UserService userService = UserServiceFactory.getUserService();

    Provider<EntityManager> entityManagerProvider;

    public SecurityInterceptor(Provider<EntityManager> entityManagerProvider) {
        this.entityManagerProvider = entityManagerProvider;
    }

    @Override
    public Object invoke(MethodInvocation invocation) throws Throwable {
        if (userService.isUserAdmin()){
            return invocation.proceed();
        }
        UserRoles userRoles = SecurityHelper.getUserRoles(entityManagerProvider);
        if (userRoles!=null){
            Set<String> rolesAllowed = new HashSet<String>();

            RolesAllowed methodRolesAllowed = invocation.getMethod().getAnnotation(RolesAllowed.class);
            if (methodRolesAllowed!=null)
                rolesAllowed.addAll(Arrays.asList(methodRolesAllowed.value()));

            RolesAllowed classRolesAllowed = invocation.getMethod().getDeclaringClass().getAnnotation(RolesAllowed.class);
            if (classRolesAllowed!=null)
                rolesAllowed.addAll(Arrays.asList(classRolesAllowed.value()));

            for (String role: rolesAllowed){
                if (userRoles.getRoles().contains(role)){
                    return invocation.proceed();
                }
            }
        }
        throw new NotAuthorizedException();
    }
}
