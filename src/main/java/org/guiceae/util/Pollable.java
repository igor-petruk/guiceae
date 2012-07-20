package org.guiceae.util;

import com.google.inject.BindingAnnotation;

import java.lang.annotation.Retention;
import java.lang.annotation.Target;

import static java.lang.annotation.ElementType.*;
import static java.lang.annotation.RetentionPolicy.RUNTIME;

/**
 * User: Igor Petruk
 * Date: 27.06.12
 * Time: 21:49
 */

@BindingAnnotation
@Target({ FIELD, TYPE }) @Retention(RUNTIME)
public @interface Pollable {
}
