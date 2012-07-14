<%@ tag pageEncoding="UTF-8" %>
<%@ tag import="org.guiceae.util.JSPInjector" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" type="java.lang.String" %>
<%@ attribute name="property" type="java.lang.String" %>
<%@ attribute name="keyByClass" type="java.lang.String"  %>

<%
    Object object = null;
    if (keyByClass!=null){
        object = JSPInjector.get(request, Class.forName(keyByClass));
    }else if(property!=null){
        object = JSPInjector.getProperty(request, property);
    }
    if (object!=null){
        if (var==null){
            %><%=object%><%
        }else{
            request.setAttribute(var, object);
        }
    }
%>
