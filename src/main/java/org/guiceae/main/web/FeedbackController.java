package org.guiceae.main.web;

import com.google.appengine.api.urlfetch.*;
import com.google.appengine.api.utils.SystemProperty;
import com.sun.jersey.api.view.Viewable;
import org.guiceae.main.model.Article;
import org.guiceae.main.model.ArticleState;
import org.guiceae.main.model.UserQuestion;
import org.guiceae.main.repositories.UserQuestionRepository;
import org.guiceae.util.UserPrincipalHolder;

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
import java.net.*;
import java.util.*;

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
    UserQuestionRepository userQuestionRepository;

    @Inject
    UserPrincipalHolder userPrincipalHolder;

    @GET
    @Path("/submit/{feed}")
    public Viewable page(@PathParam("feed")String feed){
        Map<String, Object> model = new HashMap<String, Object>();
        model.put("publicKey", publicKey);
        model.put("feed",feed);
        return new Viewable("/submitFeedback.jsp", model);
    }

    @GET
    @Path("/view/{feed}")
    public Viewable view(
            @PathParam("feed") String feed,
            @QueryParam("offset") @DefaultValue("0") Integer offset) {
        return produceFeed(feed, offset);
    }

    private Viewable produceFeed(String feed, Integer offset) {
        boolean showPending = userPrincipalHolder.get().contains("cm");
        long count = userQuestionRepository.count(feed, !showPending);
        List<UserQuestion> articles = userQuestionRepository.getFeed(feed, !showPending, offset);
        Map<String, Object> it = new HashMap<String, Object>();
        it.put("feed", articles);
        it.put("feedName", feed);
        it.put("pagesCount", (count % 5 == 0) ? count / 5 : count / 5 + 1);
        it.put("currentFirst", offset);
        return new Viewable("/questionsFeed.jsp", it);
    }

    @POST
    @Path("/publish/{id}")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response submit(@PathParam("id") Long id){
        userQuestionRepository.publish(id);
        return Response.ok().build();
    }

    @POST
    @Path("/submit/{feed}")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response submit(QuestionSubmit questionSubmit, @PathParam("feed") String feed,
                           @Context HttpServletRequest request) throws URISyntaxException, IOException {
        boolean doValidation = (SystemProperty.environment.value() == SystemProperty.Environment.Value.Production);
        if (doValidation){
            boolean validation = validateCaptcha(questionSubmit.getChallenge(),
                    questionSubmit.getResponse(), request.getRemoteAddr());
            if (!validation)
                return Response.status(Response.Status.UNAUTHORIZED).build();
        }else{
            if (questionSubmit.getResponse()!=null && !"".equals(questionSubmit.getResponse())){
                boolean validation = validateCaptcha(questionSubmit.getChallenge(),
                        questionSubmit.getResponse(), request.getRemoteAddr());
                if (!validation)
                    return Response.status(Response.Status.UNAUTHORIZED).build();
            }
        }

        UserQuestion userQuestion = new UserQuestion();
        userQuestion.setAnswer("");
        userQuestion.setAuthor(questionSubmit.getAuthor());
        userQuestion.setCreated(new Date());
        userQuestion.setFeed(feed);
        userQuestion.setQuestion(questionSubmit.getQuestion());
        userQuestion.setState(ArticleState.PENDING);

        userQuestionRepository.submitQuestion(userQuestion);

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
        httpRequest.setHeader(new HTTPHeader("Content-Type","application/x-www-form-urlencoded"));
        HTTPResponse httpResponse = urlFetchService.fetch(httpRequest);
        Scanner scanner = new Scanner(new ByteArrayInputStream(httpResponse.getContent()));
        return Boolean.parseBoolean(scanner.nextLine());
    }
}

class QuestionSubmit{
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
