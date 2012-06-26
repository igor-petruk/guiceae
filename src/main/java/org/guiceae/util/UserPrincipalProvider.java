package org.guiceae.util;

/**
 * User: Igor Petruk
 * Date: 26.06.12
 * Time: 23:21
 */
public interface UserPrincipalProvider {
    UserPrincipal loadUser(String userId);
}
