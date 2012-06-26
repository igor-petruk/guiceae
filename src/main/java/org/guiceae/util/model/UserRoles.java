package org.guiceae.util.model;

import javax.persistence.Basic;
import javax.persistence.Entity;
import javax.persistence.Id;
import java.util.*;

@Entity
public class UserRoles {
    @Id
    String userId;

    @Basic
    List<String> roles = new ArrayList<String>();

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public List<String> getRoles() {
        return roles;
    }

    public void setRoles(List<String> roles) {
        this.roles = roles;
    }
    
    public String getRolesString(){
        return Arrays.toString(roles.toArray());
    }
}