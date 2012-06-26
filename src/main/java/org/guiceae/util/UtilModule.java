package org.guiceae.util;

import com.google.inject.AbstractModule;
import com.google.inject.matcher.Matchers;

import javax.annotation.security.RolesAllowed;
import javax.persistence.EntityManager;

public class UtilModule extends AbstractModule{
    @Override
    protected void configure() {
        SecurityInterceptor securityInterceptor = new SecurityInterceptor(getProvider(UserPrincipalHolder.class));

        bindInterceptor(Matchers.any(), Matchers.annotatedWith(RolesAllowed.class), securityInterceptor);
        bindInterceptor(Matchers.annotatedWith(RolesAllowed.class), Matchers.any(), securityInterceptor);
    }
}
