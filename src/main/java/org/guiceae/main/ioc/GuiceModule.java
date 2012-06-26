package org.guiceae.main.ioc;

import com.google.appengine.api.memcache.MemcacheService;
import com.google.appengine.api.memcache.MemcacheServiceFactory;
import com.google.inject.AbstractModule;
import com.google.inject.Provides;
import org.guiceae.main.repositories.MessageRepository;
import org.guiceae.main.web.UsersController;
import org.guiceae.main.web.MainController;

public class GuiceModule extends AbstractModule{

    @Override
    protected void configure() {
        bind(MessageRepository.class);
        bind(MainController.class);
        bind(UsersController.class);
    }

    @Provides
    MemcacheService memcacheService(){
        return MemcacheServiceFactory.getMemcacheService();
    }
}
