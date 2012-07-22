<!DOCTYPE HTML PUBLIC "-//W3//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="guiceae" uri="http://guiceae.org" %>
<html>

<guiceae:head>
    <script type="text/javascript" src="/js/feed.js"></script>
</guiceae:head>

<body>
<div id="head">
    <guiceae:quick-panel/>
</div>
<div id="personal-not-main">
    <div class="name">Персональний сайт Івана Куровського</div>
    <div class="background"><img src="/css/images/system/personal_not_main.png"/></div>
</div>

<guiceae:new-menu/>


<div id="content">
    <div id="content_cen">
        <div id="content_sup">

            <div class="view-center-place">

                <a href="/app/feed/${it.feed}">Назад до стрічки</a>

                <guiceae:article shortView="false" simpleDelete="true" article="${it}" social="true"/>
            </div>

        </div>
    </div>
</div>

<guiceae:footer/>
</body>
</html>
