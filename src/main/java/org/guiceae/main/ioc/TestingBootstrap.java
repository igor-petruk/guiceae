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
        String content = "<p style=\"font-weight:bold; float:left; margin-left: 40%;margin-top: 10px;\">Шановні друзі!</p>" +

                "            <p>Мені як народному депутатові України онлайн-спілкування видається " +
                "                важливою ланкою вивчення проблем, які цікавлять людей.</p> " +

                "            <p>Користуючись цим ресурсом, Ви зможете дізнатися про мою " +
                "                депутатську, благодійну діяльність, участь у житті виборчого округу. Також ви " +
                "                маєте можливість звернутися до моєї громадської приймальні, щоб отримати " +
                "                відповіді на питання, які вас цікавлять.</p>" +
                "            <p>Я завжди готовий до обміну думками і конструктивної дискусії. Буду " +
                "                вдячний за ваші запитання і пропозиції.</p>" +
                "            <div style=\"float: right;  width: 60%; min-width: 360px;\">" +
                "                <p style=\"float:right;font-weight:bold;\">З повагою,</p>" +
                "                <p style=\"float:right;font-weight:bold;\">Народний депутат України Іван Куровський</p>" +
                "            </div>";
        article.setContent(content);
        article.setEditableContent(content);
        article.setShortContent(content);
        article.setLastUpdated(new Date());
        article.setTitle("title" + "main");
        article.setPermalink("Main_Page");
        articleRepository.mergeArticle(article);
        searchRepository.submitToSearch(article);

        article = new Article();
        article.setAuthor("test@example.com");
        article.setCreated(new Date());
        article.setState(ArticleState.PUBLISHED);
        article.setToView(new Date());
        article.setFeed("visit");
        article.setContent("<h3> something </h3> <p><b> hey </b> you</p>");
        article.setEditableContent("<h3> something </h3> <p><b> hey </b> you</p>");
        article.setShortContent("<p><b>Short content</b> version<p>");
        article.setLastUpdated(new Date());
        article.setTitle("title" + "any");
        article.setPermalink("super-title" + "any");
        articleRepository.mergeArticle(article);
        searchRepository.submitToSearch(article);

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
