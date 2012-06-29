package org.guiceae.main.model;

import org.codehaus.jackson.annotate.JsonIgnore;
import org.guiceae.util.JSONHelper;
import org.guiceae.util.UserPrincipal;

import javax.persistence.Basic;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.xml.bind.annotation.XmlTransient;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * User: Igor Petruk
 * Date: 26.06.12
 * Time: 23:16
 */
@Entity
public class UserDetails implements UserPrincipal, Serializable{
    @Id
    String email;

    @Basic
    List<String> roles = new ArrayList<String>();

    @Override
    public String getUserId() {
        return email;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    @Override
    public List<String> getRoles() {
        return roles;
    }

    public void setRoles(List<String> roles) {
        this.roles = roles;
    }
}
