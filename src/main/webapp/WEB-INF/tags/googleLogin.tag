<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ tag import="com.google.appengine.api.users.UserService" %>
<%@ tag import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ tag import="com.google.appengine.api.users.User" %><%
    UserService userService = UserServiceFactory.getUserService();
    User user = userService.getCurrentUser();
    request.setAttribute("user",userService.getCurrentUser());

    if (user!=null){
        %>
        <c:out value="${user.nickname}"/>,
        <a href="<%= userService.createLogoutURL("/app/index")%>">Logout</a>
        <%
    }else{
        %>
        <a href="<%= userService.createLoginURL("/app/index")%>">Login</a>
        <%
    }
%>