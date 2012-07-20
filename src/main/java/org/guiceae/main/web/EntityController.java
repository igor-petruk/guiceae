package org.guiceae.main.web;

import com.googlecode.objectify.NotFoundException;
import com.googlecode.objectify.Objectify;
import javax.inject.Inject;

import javax.inject.Provider;
import javax.persistence.Entity;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.lang.reflect.Field;

enum PollRequestQueryType{
    FIELD, EXISTS, NEXISTS
}

class PollRequestQuery{
    String name;
    String value;
    PollRequestQueryType type;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public PollRequestQueryType getType() {
        return type;
    }

    public void setType(PollRequestQueryType type) {
        this.type = type;
    }
}

class PollRequest{
    Class<?> entity;
    Long id;
    PollRequestQuery query;

    public Class<?> getEntity() {
        return entity;
    }

    public void setEntity(Class<?> entity) {
        this.entity = entity;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public PollRequestQuery getQuery() {
        return query;
    }

    public void setQuery(PollRequestQuery query) {
        this.query = query;
    }
}

enum PollResponseStatus{
    OK, FAILED, BAD_REQUEST
}

class PollResponse{
    PollResponseStatus status;

    PollResponse(PollResponseStatus status) {
        this.status = status;
    }

    public PollResponseStatus getStatus() {
        return status;
    }

    public void setStatus(PollResponseStatus status) {
        this.status = status;
    }
}

@Path("/app/entity")
public class EntityController {
    @Inject
    Provider<Objectify> objectifyProvider;

    @POST
    @Path("/poll")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public PollResponse poll(PollRequest request) throws NoSuchFieldException, IllegalAccessException {
        if (request.getEntity().getAnnotation(Entity.class)!=null){
            Objectify ofy = objectifyProvider.get();
            Object o = null;
            try{
                o = ofy.get(request.getEntity(), request.getId());
            }catch (NotFoundException e){

            }
            switch (request.getQuery().getType()){
                case FIELD:
                    if (o!=null){
                        Field field = request.getEntity().getDeclaredField(request.getQuery().getName());
                        field.setAccessible(true);
                        Object value = field.get(o);
                        if (String.valueOf(value).equals(request.getQuery().getValue())){
                            return new PollResponse(PollResponseStatus.OK);
                        }else{
                            return new PollResponse(PollResponseStatus.FAILED);
                        }
                    }else{
                        return new PollResponse(PollResponseStatus.BAD_REQUEST);
                    }
                case EXISTS:
                    return new PollResponse((o!=null)?PollResponseStatus.OK:PollResponseStatus.FAILED);
                case NEXISTS:
                    return new PollResponse((o==null)?PollResponseStatus.OK:PollResponseStatus.FAILED);
                }
        }else{
            throw new WebApplicationException(Response.Status.BAD_REQUEST);
        }
        throw new WebApplicationException(Response.Status.NOT_ACCEPTABLE);
    }
    
}
