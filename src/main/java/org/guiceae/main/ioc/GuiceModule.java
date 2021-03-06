package org.guiceae.main.ioc;

import com.google.appengine.api.search.Index;
import com.google.appengine.api.search.IndexSpec;
import com.google.appengine.api.search.SearchService;
import com.google.appengine.api.search.SearchServiceFactory;
import com.google.inject.AbstractModule;
import com.google.inject.Provides;
import com.google.inject.name.Names;
import org.guiceae.main.repositories.*;
import org.guiceae.main.web.*;
import org.guiceae.util.UserPrincipalProvider;
import org.guiceae.util.bootstrap.Bootstrap;
import org.guiceae.util.bootstrap.DevelopmentBootstrap;

import javax.inject.Inject;
import javax.inject.Singleton;
import java.io.IOException;
import java.util.Properties;

public class GuiceModule extends AbstractModule {
    void loadProperties() {
        Properties properties = new Properties();
        try {
            properties.load(this.getClass().getResource("/settings.properties").openStream());
            Names.bindProperties(binder(), properties);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void configure() {
        // settings
        loadProperties();

        // repos
        bind(UserRepository.class);
        bind(VideoRepository.class);
        bind(ArticleRepository.class);
        bind(SearchRepository.class);
        bind(EntityRepository.class);

        // controllers
        bind(FeedbackController.class);
        bind(MainController.class);
        bind(SearchController.class);
        bind(UsersController.class);
        bind(PhotoController.class);
        bind(AlbumController.class);
        bind(FeedsController.class);
        bind(ArticleController.class);
        bind(FeedbackController.class);
        bind(EntityController.class);

        // security
        bind(UserPrincipalProvider.class).to(UserRepository.class);

        // bootstrap
        bind(Bootstrap.class).annotatedWith(DevelopmentBootstrap.class).to(TestingBootstrap.class);
    }

    @Provides
    @Singleton
    @Inject
    public Index index(SearchService searchService) {
        IndexSpec indexSpec = IndexSpec.newBuilder()
                .setName("documents")
                .build();
        return searchService.getIndex(indexSpec);
    }

    @Provides
    SearchService searchService() {
        return SearchServiceFactory.getSearchService();
    }
}
