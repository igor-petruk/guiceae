<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="guiceae" uri="http://guiceae.org" %>
<html>
<head>
    <guiceae:head/>
</head>
<body>
<div class="main page ui-widget-content">
    <guiceae:menu/>

    <div class="collage" id="mainMenuCollage"></div>

    <div id="feed-place">
        <div class="gutter-outer"></div>
        <div id="news" class="column feed"></div>
        <div class="gutter"></div>
        <div id="charity" class="column feed"></div>
        <div class="gutter"></div>
        <div id="people-chat" class="column feed"></div>
        <div class="gutter-outer"></div>
    </div>
</div>
</body>
</html>
