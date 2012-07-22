<%@ tag pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="guiceae" uri="http://guiceae.org" %>

<div id="menu">
    <ul>
        <li><a id="menu-main" href="/app/feed/news">Новини</a></li>
        <li><a id="menu-guest" href="/app/feed/guestroom">Громадська приймальня</a></li>
        <li><a id="menu-activity" href="/app/feed/activity">Депутатська діяльність</a></li>
        <li><a id="menu-gallery" href="/app/album/gallery">Галерея</a></li>
        <li><a id="menu-biography" href="/app/feed/biography">Автобіографія</a></li>
        <li><guiceae:googleLogin/></li>
    </ul>
    <jsp:doBody/>
</div>