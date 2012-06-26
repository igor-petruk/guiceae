package org.guiceae.util;

import java.util.Collection;

/**
 * User: Igor Petruk
 * Date: 26.06.12
 * Time: 23:05
 */
public interface UserPrincipal {
    Collection<String> getRoles();
    String getUserId();
}
