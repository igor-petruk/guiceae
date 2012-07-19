package org.guiceae.main.ioc;

import com.google.common.collect.ImmutableSet;
import org.guiceae.main.model.Article;
import org.guiceae.main.model.ArticleState;
import org.guiceae.main.model.UserDetails;
import org.guiceae.main.repositories.ArticleRepository;
import org.guiceae.main.repositories.SearchRepository;
import org.guiceae.main.repositories.UserRepository;
import org.guiceae.util.bootstrap.Bootstrap;

import javax.inject.Inject;
import java.util.Date;

import static org.guiceae.main.model.Roles.*;

/**
 * User: Igor Petruk
 * Date: 27.06.12
 * Time: 21:53
 */

public class TestingBootstrap implements Bootstrap {
    UserRepository userRepository;
    ArticleRepository articleRepository;
    SearchRepository searchRepository;

    @Inject
    public TestingBootstrap(UserRepository userRepository,
                            ArticleRepository articleRepository,
                            SearchRepository searchRepository) {
        this.userRepository = userRepository;
        this.articleRepository = articleRepository;
        this.searchRepository = searchRepository;
    }

    @Override
    public void bootstrap() {
        UserDetails userDetails = new UserDetails();
        userDetails.setEmail("test@example.com");
        userDetails.getRoles().addAll(ImmutableSet.of(ADMIN, CONTENT_MANAGER, VIDEO_MANAGER));

        userRepository.save(userDetails);

        Article article = new Article();
        article.setAuthor("test@example.com");
        article.setCreated(new Date());
        article.setState(ArticleState.PUBLISHED);
        article.setFeed("news");
        article.setContent("<h3> something </h3> <p><b> hey </b> you</p>");
        article.setShortContent("<p><b>Short content</b> version<p>");
        article.setLastUpdated(new Date());
        article.setTitle("title");
        article.setPermalink("super-title");
        articleRepository.mergeArticle(article);
        searchRepository.submitToSearch(article);
//
//        article = new Article();
//        article.setAuthor("test@example.com");
//        article.setCreated(new Date());
//        article.setState(ArticleState.PUBLISHED);
//        article.setFeed("news");
//        article.setContent("<h3> Ololoev </h3> <p><b> hey </b> you</p>");
//        article.setShortContent("<p><b>SHORT CONTENT</b> Кириллица<p>");
//        article.setLastUpdated(new Date());
//        article.setTitle("Another article");
//        article.setPermalink("another-article");
//        articleRepository.mergeArticle(article);
//        searchRepository.submitToSearch(article);
    }
}
