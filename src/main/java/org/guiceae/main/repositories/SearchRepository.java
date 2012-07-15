package org.guiceae.main.repositories;

import com.google.appengine.api.search.*;
import org.guiceae.main.model.Article;

import javax.inject.Inject;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

public class SearchRepository {
    Index index;
    SearchService searchService;
    
    @Inject
    public SearchRepository(Index index, SearchService searchService) {
        this.index = index;
        this.searchService = searchService;
    }
    
    public Results<ScoredDocument> search(String query){
        return index.search(query);
    }

    public void submitToSearch(Article article){
        Document document = Document.newBuilder()
                .setId(article.getPermalink())
                .addField(Field.newBuilder().setName("content").setHTML(article.getContent()))
                .addField(Field.newBuilder().setName("shortContent").setHTML(article.getShortContent()))
                .addField(Field.newBuilder().setName("title").setText(article.getTitle()))
                .addField(Field.newBuilder().setName("created").setDate(dateOnly(article.getCreated())))
                .addField(Field.newBuilder().setName("updated").setDate(dateOnly(article.getLastUpdated())))
                .addField(Field.newBuilder().setName("feed").setText(article.getFeed()))
                .addField(Field.newBuilder().setName("state").setText(String.valueOf(article.getState())))
                .addField(Field.newBuilder().setName("id").setText(String.valueOf(article.getId())))
                .addField(Field.newBuilder().setName("author").setText(article.getAuthor()))
                .build();
        index.add(document);
    }

    private Date dateOnly(Date dateTime){
        Calendar cal = Calendar.getInstance();
        cal.setTime(dateTime);

        cal.set(Calendar.HOUR_OF_DAY, 0);
        cal.set(Calendar.MINUTE, 0);
        cal.set(Calendar.SECOND, 0);
        cal.set(Calendar.MILLISECOND, 0);

        return cal.getTime();
    }

    public void deleteFromSearch(Article article){
       index.remove(article.getPermalink());
    }
}
