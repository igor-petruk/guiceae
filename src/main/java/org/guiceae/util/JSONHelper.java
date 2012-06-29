package org.guiceae.util;

import org.codehaus.jackson.map.ObjectMapper;

/**
 * User: Igor Petruk
 * Date: 28.06.12
 * Time: 23:54
 */
public class JSONHelper {
    public static String toJSON(Object o){
        try{
            ObjectMapper objectMapper = new ObjectMapper();
            return objectMapper.writeValueAsString(o);
        }catch (Exception e){
            throw new IllegalArgumentException("Unable to convert ot JSON"+o);
        }
    }
}
