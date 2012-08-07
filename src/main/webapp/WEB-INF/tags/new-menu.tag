<%@ tag pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="guiceae" uri="http://guiceae.org" %>

<div id="menu">
    <ul>
        <li><a id="menu-biography" href="/app/feed/biography">Біографія</a></li>
        <li><a id="menu-activity" href="/app/feed/charity">Депутатська діяльність, благодійність</a></li>
        <li><a id="menu-main" href="/app/feed/news">Новини, ЗМІ</a></li>
        <li><a id="menu-gallery" href="/app/album/gallery">Галерея</a></li>
    </ul>
    <jsp:doBody/>
</div>