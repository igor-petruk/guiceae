package org.guiceae.main.ioc;

import com.google.appengine.api.memcache.MemcacheService;
import com.google.appengine.api.memcache.MemcacheServiceFactory;
import com.google.inject.AbstractModule;
import com.google.inject.Provides;
import org.guiceae.main.repositories.MessageRepository;
import org.guiceae.main.web.MainController;
import org.guiceae.main.web.PhotoController;
import org.guiceae.main.web.UsersController;

public class GuiceModule extends AbstractModule {

    @Override
    protected void configure() {
        bind(MessageRepository.class);
        bind(MainController.class);
        bind(UsersController.class);
        bind(PhotoController.class);
    }

    @Provides
    MemcacheService memcacheService() {
        return MemcacheServiceFactory.getMemcacheService();
    }
}
