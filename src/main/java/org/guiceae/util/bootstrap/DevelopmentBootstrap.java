package org.guiceae.util.bootstrap;

import com.google.inject.BindingAnnotation;

import java.lang.annotation.Retention;
import java.lang.annotation.Target;

import static java.lang.annotation.RetentionPolicy.RUNTIME;
import static java.lang.annotation.ElementType.*;

/**
 * User: Igor Petruk
 * Date: 27.06.12
 * Time: 21:49
 */

@BindingAnnotation
@Target({ FIELD, PARAMETER, METHOD }) @Retention(RUNTIME)
public @interface DevelopmentBootstrap {
}
