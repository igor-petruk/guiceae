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
<%--<a class="dock-item" href="#"><span>Good day, <c:out value="${user.nickname}"/></span></a>--%>
<div style="margin-top: -40px;float: right;"><a href="<%= userService.createLogoutURL("/app/index")%>">
    <img src="/css/images/system/hr3.png" alt="Logout" height="64" width="64"/>
</a></div>
<%
} else {
%>
<div style="margin-top: -40px;float: right;"><a href="<%= userService.createLoginURL("/app/index")%>">
    <img src="/css/images/system/hr.png" alt="Login" height="64" width="64"/>
</a></div>
<%
    }
%>