<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="guiceae" uri="http://guiceae.org" %>

<div class="menu">
    <div><a href="/app/index">Home</a></div>
    <div><a href="/app/contacts">Contact</a></div>
    <div><a href="/app/feed/charity">Charity</a></div>
    <div><a href="/app/feed/news">News</a></div>
    <div><a href="/app/feed/biography">Biography</a></div>
    <div><a href="/app/feed/rss">RSS</a></div>
    <div><a href="/app/album/gallery">Gallery</a></div>
    <jsp:doBody/>
</div>
<guiceae:googleLogin/>

<div id="pic" style="display: none;">
    <div class="menuItemJS"><img src="/css/images/dock-menu/flag2.PNG"/></div>
</div>