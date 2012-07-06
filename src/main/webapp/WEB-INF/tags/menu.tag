<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="guiceae" uri="http://guiceae.org" %>

<guiceae:head/>

<div class="menu">
    <a href="/app/index">Home</a>
    <a href="/app/contacts">Contact</a>
    <guiceae:rolesOnly roles="admin">
        <a href="/app/users">Users</a>
        <a href="/app/photo/new">Add photo</a>
        <a href="/app/album/new">Add album</a>
        <a href="/app/article/new">Add article</a>
        <a href="/app/feed/new">Add feed</a>
        <a href="/app/album/all">Albums</a>
    </guiceae:rolesOnly>
    <guiceae:googleLogin/>
    <a href="/app/rss">RSS</a>
    <jsp:doBody/>
</div>