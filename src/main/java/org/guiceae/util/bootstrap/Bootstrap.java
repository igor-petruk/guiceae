package org.guiceae.util.bootstrap;

import javax.persistence.EntityManager;

/**
 * User: Igor Petruk
 * Date: 27.06.12
 * Time: 21:47
 */
public interface Bootstrap {
    void bootstrap(EntityManager entityManager);
}
