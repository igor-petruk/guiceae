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


<div class="login"><a href="<%= userService.createLogoutURL("/app/index")%>">
    <img src="/css/images/system/hr3.png" alt="Logout" height="64" width="64"/>
</a></div>


<%
} else {
%>


<div class="login"><a href="<%= userService.createLoginURL("/app/index")%>">
    <img src="/css/images/system/hr.png" alt="Login" height="64" width="64"/>
</a></div>


<%
    }
%>