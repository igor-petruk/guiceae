<%@ tag pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ tag import="com.google.appengine.api.users.User" %>
<%@ tag import="com.google.appengine.api.users.UserService" %>
<%@ tag import="com.google.appengine.api.users.UserServiceFactory" %>
<%
    UserService userService = UserServiceFactory.getUserService();
    User user = userService.getCurrentUser();
    request.setAttribute("user", userService.getCurrentUser());
    if (user != null) {
%>


<a href="<%= userService.createLogoutURL("/app/index")%>">
    login
</a>
<%
} else {
%>
<a href="<%= userService.createLoginURL("/app/index")%>">
    logout
</a>
<%
    }
%>