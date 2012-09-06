package org.guiceae.main.ioc;

import com.google.common.collect.ImmutableSet;
import org.guiceae.main.model.*;
import org.guiceae.main.repositories.ArticleRepository;
import org.guiceae.main.repositories.FeedbackRepository;
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
    FeedbackRepository feedbackRepository;

    @Inject
    public TestingBootstrap(UserRepository userRepository,
                            ArticleRepository articleRepository,
                            SearchRepository searchRepository,
                            FeedbackRepository feedbackRepository) {
        this.userRepository = userRepository;
        this.articleRepository = articleRepository;
        this.searchRepository = searchRepository;
        this.feedbackRepository = feedbackRepository;
    }

    @Override
    public void bootstrap() {
        UserDetails userDetails = new UserDetails();
        userDetails.setEmail("test@example.com");
        userDetails.getRoles().addAll(ImmutableSet.of(ADMIN, CONTENT_MANAGER, VIDEO_MANAGER));

        userRepository.save(userDetails);

        for (int i = 0; i < 15; i++) {
            Article article = new Article();
            article.setAuthor("test@example.com");
            article.setCreated(new Date());
            article.setState(ArticleState.PUBLISHED);
            article.setToView(new Date());
            article.setFeed("news");
            article.setContent("<h3> something </h3> <p><b> hey </b> you</p>");
            article.setEditableContent("<h3> something </h3> <p><b> hey </b> you</p>");
            article.setShortContent("<p><b>Short content</b> version<p>");
            article.setLastUpdated(new Date());
            article.setTitle("title" + i);
            article.setPermalink("super-title" + i);
            articleRepository.mergeArticle(article);
            searchRepository.submitToSearch(article);
        }

        for (int i = 0; i < 15; i++) {
            Article article = new Article();
            article.setAuthor("test@example.com");
            article.setCreated(new Date());
            article.setState(ArticleState.PUBLISHED);
            article.setToView(new Date());
            article.setFeed("charity");
            article.setContent("<h3> something </h3> <p><b> hey </b> you</p>");
            article.setEditableContent("<h3> something </h3> <p><b> hey </b> you</p>");
            article.setShortContent("<p><b>Short content</b> version<p>");
            article.setLastUpdated(new Date());
            article.setTitle("title" + i);
            article.setPermalink("super-title" + i);
            articleRepository.mergeArticle(article);
            searchRepository.submitToSearch(article);
        }

        Article article = new Article();
        article.setAuthor("");
        article.setCreated(new Date());
        article.setState(ArticleState.PUBLISHED);
        article.setToView(new Date());
        article.setFeed("main");
        String content = "<p style=\"font-weight:bold; float:left; margin-left: 40%;margin-top: 10px;\">Шановні друзі!</p>\n" +
                "\n" +
                "            <p>Мені як народному депутатові України онлайн-спілкування видається\n" +
                "                важливою ланкою вивчення проблем, які цікавлять людей.</p>\n" +
                "\n" +
                "            <p>Користуючись цим ресурсом, Ви зможете дізнатися про мою\n" +
                "                депутатську, благодійну діяльність, участь у житті виборчого округу. Також ви\n" +
                "                маєте можливість звернутися до моєї громадської приймальні, щоб отримати\n" +
                "                відповіді на питання, які вас цікавлять.</p>\n" +
                "\n" +
                "            <p>Я завжди готовий до обміну думками і конструктивної дискусії. Буду\n" +
                "                вдячний за ваші запитання і пропозиції.</p>\n" +
                "\n" +
                "            <div style=\"float: right;  width: 60%; min-width: 360px;\">\n" +
                "                <p style=\"float:right;font-weight:bold;\">З повагою,</p>\n" +
                "\n" +
                "                <p style=\"float:right;font-weight:bold;\">Народний депутат України Іван Куровський</p>\n" +
                "            </div>";
        article.setContent(content);
        article.setEditableContent(content);
        article.setShortContent(content);
        article.setLastUpdated(new Date());
        article.setPermalink("Main Page");
        articleRepository.mergeArticle(article);

        Feedback feedback = new Feedback();
        feedback.setFeed(FeedbackFeedType.QUESTION);

        StringBuffer strBuf = new StringBuffer();
        for (int i = 0; i < 1000; i++) {
            strBuf.append("  ").append(i);
        }

        feedback.setAnswer("Question:" + strBuf);
        feedback.setId(1L);
        feedback.setAuthor("RoksanaSeletska@kjshdkf");
        feedback.setCreated(new Date());
        feedback.setQuestion("Answer:" + strBuf);
        feedback.setState(ArticleState.PUBLISHED);
        feedbackRepository.submitQuestion(feedback);
        feedbackRepository.submitQuestion(feedback);
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
