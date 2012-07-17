package org.guiceae.main.model;

import javax.persistence.*;
import java.util.Date;

public class Feedback {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;

    String author;

    @Enumerated(EnumType.STRING)
    FeedbackFeedType feed;

    Date created;

    String question, answer;

    @Enumerated(EnumType.STRING)
    ArticleState state = ArticleState.PENDING;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public FeedbackFeedType getFeed() {
        return feed;
    }

    public void setFeed(FeedbackFeedType feed) {
        this.feed = feed;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public Date getCreated() {
        return created;
    }

    public void setCreated(Date created) {
        this.created = created;
    }

    public String getQuestion() {
        return question;
    }

    public void setQuestion(String question) {
        this.question = question;
    }

    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }

    public ArticleState getState() {
        return state;
    }

    public void setState(ArticleState state) {
        this.state = state;
    }
}
