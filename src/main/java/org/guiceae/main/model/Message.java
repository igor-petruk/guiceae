
package org.guiceae.main.model;

import com.google.appengine.api.datastore.Text;

import javax.persistence.*;
import java.io.Serializable;

@Entity
public class Message implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Lob
	private Text text;

    public Message(String text) {
        this.text = new Text(text);
    }

    public Message() {
    }

    public String getText() {
		return text.getValue();
	}
	
	public void setText(String text) {
		this.text = new Text(text);
	}

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    @Override
    public String toString() {
        return "Message{" +
                "id=" + id +
                ", text='" + text + '\'' +
                '}';
    }
}
