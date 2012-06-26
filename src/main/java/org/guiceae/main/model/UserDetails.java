package org.guiceae.main.model;

import org.guiceae.util.UserPrincipal;

import javax.persistence.Basic;
import javax.persistence.Entity;
import javax.persistence.Id;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * User: Igor Petruk
 * Date: 26.06.12
 * Time: 23:16
 */
@Entity
public class UserDetails implements UserPrincipal{
    @Id
    String userId;

    @Basic
    List<String> roles = new ArrayList<String>();

    @Override
    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    @Override
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
