package org.guiceae.util;

import com.google.inject.Guice;
import com.google.inject.Injector;
import com.google.inject.Provides;
import com.google.inject.servlet.GuiceServletContextListener;
import com.google.inject.servlet.ServletModule;
import com.googlecode.objectify.Objectify;
import com.googlecode.objectify.ObjectifyService;
import com.sun.jersey.api.json.JSONConfiguration;
import com.sun.jersey.guice.spi.container.servlet.GuiceContainer;
import org.guiceae.main.ioc.GuiceModule;
import org.guiceae.main.web.CkUploadServlet;
import org.guiceae.main.web.UploadServlet;

import javax.ws.rs.ext.Provider;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Logger;

public class GuiceConfig extends GuiceServletContextListener {
    Logger log = Logger.getLogger(GuiceConfig.class.getName());

    protected Injector getInjector() {

        final Map<String, String> params = new HashMap<String, String>();
        params.put("javax.ws.rs.Application", JaxrsControllersConfig.class.getName());
        params.put(JSONConfiguration.FEATURE_POJO_MAPPING,"true");
        params.put("com.sun.jersey.config.property.JSPTemplatesBasePath","/WEB-INF/jsp");

        Injector injector = Guice.createInjector(
                new UtilModule(),
                new ServletModule() {
                    @Provides
                    public Objectify objectify(){
                        return ObjectifyService.begin();
                    }

                    @Override
                    protected void configureServlets() {
                        bind(UserPrincipalHolder.class);

                        serve("/app/upload").with(UploadServlet.class);
                        serve("/app/ckupload").with(CkUploadServlet.class);
                        serve("/*").with(GuiceContainer.class, params);
                        filter("/*").through(EncodingFilter.class);
                        filter("/*").through(InjectorFilter.class);
                        filter("/*").through(SecurityFilter.class);
                    }
                },
                new GuiceModule());

        return injector;
    }
}
