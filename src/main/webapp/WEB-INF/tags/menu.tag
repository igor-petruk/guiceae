<%@ tag pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="guiceae" uri="http://guiceae.org" %>

<div class="menu">
    <div><a href="/app/index">Home</a></div>
    <div><a href="/app/contacts">Contact</a></div>
    <div><a href="/app/contacts">Charity</a></div>
    <div><a href="/app/contacts">News</a></div>
    <div><a href="/app/contacts">Biography</a></div>
    <div><a href="/app/rss">RSS</a></div>
    <%--<guiceae:rolesOnly roles="admin">--%>
    <%--<div><a href="/app/users">Users</a></div>--%>
    <%--<div><a href="/app/photo/new">Add photo</a></div>--%>
    <%--<div><a href="/app/album/new">Add album</a></div>--%>
    <%--<div><a href="/app/article/new">Add article</a></div>--%>
    <%--<div><a href="/app/feed/new">Add feed</a></div>--%>
    <%--<div><a href="/app/album/all">Albums</a></div>--%>
    <%--</guiceae:rolesOnly>--%>
    <jsp:doBody/>
</div>
<guiceae:googleLogin/>

<div id="pic" style="display: none;">
    <div class="menuItemJS"><img src="/css/images/dock-menu/flag2.PNG"/></div>
</div>