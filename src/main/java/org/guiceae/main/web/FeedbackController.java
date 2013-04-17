package org.guiceae.main.web;

import com.google.appengine.api.urlfetch.*;
import com.google.appengine.api.utils.SystemProperty;
import com.sun.jersey.api.view.Viewable;
import org.guiceae.main.model.ArticleState;
import org.guiceae.main.model.Feedback;
import org.guiceae.main.model.FeedbackFeedType;
import org.guiceae.main.repositories.FeedbackRepository;
import org.guiceae.util.UserPrincipalHolder;

import javax.annotation.security.RolesAllowed;
import javax.inject.Inject;
import javax.inject.Named;
import javax.inject.Singleton;
import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.*;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;

@Singleton
@Path("/app/feedback")
public class FeedbackController {
    @Inject
    @Named("captchaPublicKey")
    String publicKey;

    @Inject
    @Named("captchaPrivateKey")
    String privateKey;

    @Inject
    FeedbackRepository feedbackRepository;

    @Inject
    UserPrincipalHolder userPrincipalHolder;

    @GET
    @Path("/submit/{feed}")
    public Viewable page(@PathParam("feed") String feedString,
                         @QueryParam("offset") @DefaultValue("0") Integer offset) {
        boolean showPending = userPrincipalHolder.get().contains("cm");
        FeedbackFeedType feed = FeedbackFeedType.valueOf(feedString.toUpperCase());
        long count = feedbackRepository.count(feed, !showPending);

        Map<String, Object> model = new HashMap<String, Object>();
        model.put("publicKey", publicKey);
        model.put("feed", feedString);
        model.put("feedbacks", feedbackRepository.getFeed(feed, !showPending, offset));
        model.put("pagesCount", (count % 5 == 0) ? count / 5 : count / 5 + 1);
        model.put("currentFirst", offset);

        if (feed.equals(FeedbackFeedType.QUESTION)) {
            model.put("theme", "Питання та відповіді");
            model.put("proposition", "Залиште своє питання тут");
            model.put("proposition_area", "Ваше питання");
        } else {
            model.put("theme", "Відгуки");
            model.put("proposition", "Залиште свій відгук тут");
            model.put("proposition_area", "Ваш відгук");
        }
        return new Viewable("/feedbacks.jsp", model);

    }
//
//    @GET
//    @Path("/view/{feed}")
//    public Viewable view(
//            @PathParam("feed") String feedString,
//            @QueryParam("offset") @DefaultValue("0") Integer offset) {
//        FeedbackFeedType feed = FeedbackFeedType.valueOf(feedString.toUpperCase());
//        return produceFeed(feed, offset);
//    }
//
//    private Viewable produceFeed(FeedbackFeedType feed, Integer offset) {
//        boolean showPending = userPrincipalHolder.get().contains("cm");
//        long count = feedbackRepository.count(feed, !showPending);
//        List<Feedback> articles = feedbackRepository.getFeed(feed, !showPending, offset);
//        Map<String, Object> it = new HashMap<String, Object>();
//        it.put("feed", articles);
//        it.put("feedName", feed);
//        it.put("pagesCount", (count % 5 == 0) ? count / 5 : count / 5 + 1);
//        it.put("currentFirst", offset);
//        return new Viewable("/feedbackFeed.jsp", it);
//    }

    @DELETE
    @Path("/delete/{id}")
    @RolesAllowed("cm")
    public Response delete(@PathParam("id") Long id) throws URISyntaxException {
        feedbackRepository.delete(id);
        return Response.ok().build();
    }

    @POST
    @Path("/publish/{id}")
    @Consumes(MediaType.APPLICATION_JSON)
    @RolesAllowed("cm")
    public Response submit(@PathParam("id") Long id) {
        feedbackRepository.publish(id);
        return Response.ok().build();
    }

    @GET
    @Path("/edit/{id}")
    @RolesAllowed("cm")
    public Viewable editFeedback(@PathParam("id") Long id) {
        Feedback feedback = feedbackRepository.getFeedback(id);
        return new Viewable("/editFeedback.jsp", feedback);
    }

    @POST
    @Path("/submit/{feed}")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response submit(QuestionSubmit questionSubmit, @PathParam("feed") String feedString,
                           @Context HttpServletRequest request) throws URISyntaxException, IOException {
        FeedbackFeedType feed = FeedbackFeedType.valueOf(feedString.toUpperCase());
        boolean doValidation = (SystemProperty.environment.value() == SystemProperty.Environment.Value.Production);
        if (doValidation) {
            boolean validation = validateCaptcha(questionSubmit.getChallenge(),
                    questionSubmit.getResponse(), request.getRemoteAddr());
            if (!validation)
                return Response.status(Response.Status.UNAUTHORIZED).build();
        } else {
            if (questionSubmit.getResponse() != null && !"".equals(questionSubmit.getResponse())) {
                boolean validation = validateCaptcha(questionSubmit.getChallenge(),
                        questionSubmit.getResponse(), request.getRemoteAddr());
                if (!validation)
                    return Response.status(Response.Status.UNAUTHORIZED).build();
            }
        }

        Feedback feedback = new Feedback();
        feedback.setAnswer("");
        feedback.setAuthor(questionSubmit.getAuthor());
        feedback.setCreated(new Date());
        feedback.setFeed(feed);
        feedback.setQuestion(questionSubmit.getQuestion());
        feedback.setState(ArticleState.PENDING);

        feedbackRepository.submitQuestion(feedback);

        return Response.ok().build();
    }

    private boolean validateCaptcha(String challenge, String response, String ip)
            throws URISyntaxException, IOException {
        URLFetchService urlFetchService = URLFetchServiceFactory.getURLFetchService();
        HTTPRequest httpRequest = new HTTPRequest(
                new URL("http://www.google.com/recaptcha/api/verify"),
                HTTPMethod.POST);
        StringBuilder query = new StringBuilder();

        query
                .append("privatekey=").append(privateKey)
                .append("&remoteip=").append(ip)
                .append("&challenge=").append(challenge)
                .append("&response=").append(URLEncoder.encode(response, "UTF-8"));

        httpRequest.setPayload(query.toString().getBytes("UTF-8"));
        httpRequest.setHeader(new HTTPHeader("Content-Type", "application/x-www-form-urlencoded"));
        HTTPResponse httpResponse = urlFetchService.fetch(httpRequest);
        Scanner scanner = new Scanner(new ByteArrayInputStream(httpResponse.getContent()));
        return Boolean.parseBoolean(scanner.nextLine());
    }

    @POST
    @Path("/save")
    @RolesAllowed("cm")
    public Response saveArticle(@FormParam("id") Long id,
                                @FormParam("feed") String feedString,
                                @FormParam("question") String question,
                                @FormParam("answer") String answer,
                                @FormParam("author") String author) throws URISyntaxException {
        FeedbackFeedType feedbackFeedType = FeedbackFeedType.valueOf(feedString);
        Feedback feedback = feedbackRepository.getFeedback(id);
        feedback.setAuthor(author);
        feedback.setQuestion(question);
        feedback.setAnswer(answer);
        feedback.setFeed(feedbackFeedType);
        feedbackRepository.submitQuestion(feedback);
        return Response.seeOther(new URI("/app/feedback/submit/" + feedString.toLowerCase())).build();
    }

}

class QuestionSubmit {
    String question, challenge, response, author;

    public String getQuestion() {
        return question;
    }

    public void setQuestion(String question) {
        this.question = question;
    }

    public String getChallenge() {
        return challenge;
    }

    public void setChallenge(String challenge) {
        this.challenge = challenge;
    }

    public String getResponse() {
        return response;
    }

    public void setResponse(String response) {
        this.response = response;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }
}
