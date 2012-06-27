package org.guiceae.main.ioc;

import org.guiceae.main.model.Message;
import org.guiceae.util.bootstrap.Bootstrap;

import javax.inject.Inject;
import javax.persistence.EntityManager;
import java.util.Date;

/**
 * User: Igor Petruk
 * Date: 27.06.12
 * Time: 21:53
 */

public class TestingBootstrap implements Bootstrap{
    @Override
    public void bootstrap(EntityManager entityManager) {
        Message message = new Message();
        message.setText(new Date().toString());

        entityManager.persist(message);
    }
}
