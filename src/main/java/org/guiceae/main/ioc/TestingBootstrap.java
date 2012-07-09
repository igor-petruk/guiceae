package org.guiceae.main.ioc;

import com.google.common.collect.ImmutableSet;
import org.guiceae.main.model.Article;
import org.guiceae.main.model.ArticleState;
import org.guiceae.main.model.Message;
import org.guiceae.main.model.UserDetails;
import org.guiceae.main.repositories.ArticleRepository;
import org.guiceae.main.repositories.MessageRepository;
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

public class TestingBootstrap implements Bootstrap{
    UserRepository userRepository;
    ArticleRepository articleRepository;
    MessageRepository messageRepository;

    @Inject
    public TestingBootstrap(UserRepository userRepository,
                            ArticleRepository articleRepository,
                            MessageRepository messageRepository) {
        this.userRepository = userRepository;
        this.articleRepository = articleRepository;
        this.messageRepository = messageRepository;
    }

    @Override
    public void bootstrap() {
        Message message = new Message();
        message.setText(new Date().toString());

        messageRepository.create(message);

        UserDetails userDetails = new UserDetails();
        userDetails.setEmail("test@example.com");
        userDetails.getRoles().addAll(ImmutableSet.of(ADMIN,CONTENT_MANAGER,VIDEO_MANAGER));

        userRepository.save(userDetails);

        Article article = new Article();
        article.setAuthor("test@examle.com");
        article.setCreated(new Date());
        article.setState(ArticleState.PENDING);
        article.setFeed("news");
        article.setContent("<h3> something </h3> <p><b> hey </b> you</p>");
        article.setLastUpdated(new Date());
        article.setTitle("Super title");
        article.setPermalink("super-title");
        articleRepository.storeArticle(article);
    }
}
