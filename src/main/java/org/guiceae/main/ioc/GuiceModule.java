package org.guiceae.main.ioc;

import com.google.appengine.api.memcache.MemcacheService;
import com.google.appengine.api.memcache.MemcacheServiceFactory;
import com.google.inject.AbstractModule;
import com.google.inject.Provides;
import org.guiceae.main.repositories.MessageRepository;
import org.guiceae.main.repositories.UserRepository;
import org.guiceae.main.web.PhotoController;
import org.guiceae.main.web.UsersController;
import org.guiceae.main.web.MainController;
import org.guiceae.util.UserPrincipalProvider;
import org.guiceae.util.bootstrap.Bootstrap;
import org.guiceae.util.bootstrap.DevelopmentBootstrap;

public class GuiceModule extends AbstractModule {

    @Override
    protected void configure() {
        // repos
        bind(MessageRepository.class);
        bind(UserRepository.class);

        // controllers
        bind(MainController.class);
        bind(UsersController.class);
        bind(PhotoController.class);

        // security
        bind(UserPrincipalProvider.class).to(UserRepository.class);
        
        // bootstrap
        bind(Bootstrap.class).annotatedWith(DevelopmentBootstrap.class).to(TestingBootstrap.class);
    }
}
