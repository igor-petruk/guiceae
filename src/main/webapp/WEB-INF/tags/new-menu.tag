<%@ tag pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="guiceae" uri="http://guiceae.org" %>

<div id="menu">
    <ul>
        <li><a id="main" href="/app/index/main">Головна</a></li>
        <li><a id="biography" href="#">Автобіографія</a></li>
        <li><a id="activity" href="#">Депутатська діяльність</a></li>
        <li><a id="gallery" href="/app/album/gallery">Галерея</a></li>
        <jsp:doBody/>
    </ul>
</div>

<%--<div class="menu">--%>
<%--<div><a href="/app/index">Home</a></div>--%>
<%--<div><a href="/app/contacts">Contact</a></div>--%>
<%--<div><a href="/app/feed/charity">Charity</a></div>--%>
<%--<div><a href="/app/feed/news">News</a></div>--%>
<%--<div><a href="/app/feed/biography">Biography</a></div>--%>
<%--<div><a href="/app/feed/rss">RSS</a></div>--%>
<%--<div><a href="/app/album/gallery">Gallery</a></div>--%>

<%--</div>--%>
<%--<guiceae:googleLogin/>--%>