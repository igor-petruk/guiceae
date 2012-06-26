<%@ tag import="org.guiceae.util.UserPrincipalHolder" %>
<%@ tag import="java.util.Set" %>
<%@ tag import="org.guiceae.util.JSPInjector" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="roles" required="true" %>

<%
    boolean show = false;

    Set<String> userRoles = JSPInjector.get(request, UserPrincipalHolder.class).get();

    if (userRoles!=null){
        String[] rolesArray = roles.split(",");
        for (String role:rolesArray){
            if (userRoles.contains(role)){
                show = true;
                break;
            }
        }
    }
    
    if (show){
        %>
        <jsp:doBody/>
        <%
    }
%>
