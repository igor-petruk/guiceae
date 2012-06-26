<%@ tag import="com.google.appengine.api.users.User" %>
<%@ tag import="com.google.appengine.api.users.UserService" %>
<%@ tag import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ tag import="org.guiceae.util.model.UserRoles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="roles" required="true" %>

<%
    UserService userService = UserServiceFactory.getUserService();
    User user = userService.getCurrentUser();
    boolean show = false;
    
    if (user!=null){
        if (userService.isUserAdmin()){
            show = true;
        }else{
            UserRoles userRoles = (UserRoles)request.getAttribute("userRoles");
            if (userRoles!=null){
                String[] rolesArray = roles.split(",");
                for (String role:rolesArray){
                    if (userRoles.getRoles().contains(role)){
                        show = true;
                        break;
                    }
                }
            }
        }
    }
    
    if (show){
        %>
        <jsp:doBody/>
        <%
    }
%>
