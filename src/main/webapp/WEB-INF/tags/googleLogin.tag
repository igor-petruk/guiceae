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
<a class="login-dock-item" href="<%= userService.createLogoutURL("/app/index")%>"><img
        src="/css/images/dock-menu/login.png"
        alt="contact"/><span>Logout</span></a>
<%
} else {
%>
<a class="login-dock-item" href="<%= userService.createLoginURL("/app/index")%>"><img
        src="/css/images/dock-menu/login.png"
        alt="contact"/><span>Login</span></a>
<%
    }
%>