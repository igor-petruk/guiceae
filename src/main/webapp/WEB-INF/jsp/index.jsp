<!DOCTYPE HTML PUBLIC "-//W3//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="guiceae" uri="http://guiceae.org" %>

<html>

<guiceae:head>
    <script type="text/javascript" charset="utf-8">
        $(function () {
            var news = $.ajax({
                url:'/app/feed/news',
                type:'GET'
            });

            for (var i in news) {
                var title = $("<a class='title' href='" + news[i].permalink + "'></a>").append(news[i].title);
                var content = $("<div class='content'></div>").append(news[i].content);
                var article = $("<div class='article'></div>").append(title);
                var article = article.append(content);
                $("#news").append(article);
            }
        })

    </script>
</guiceae:head>

<body>

<div id="main-container">
    <guiceae:admin-menu/>
    <div class="body" align="center">
        <div class="collage">
            <%--<img src="collage"/>--%>
            <div id="greetings">
            </div>
        </div>
        <div id="feed-place">
            <div class="gutter-outer"></div>
            <div id="news" class="column feed">

            </div>
            <div class="gutter"></div>
            <div id="charity" class="column feed">

            </div>
            <div class="gutter"></div>
            <div id="people-chat" class="column feed"></div>
            <div class="gutter-outer"></div>
        </div>
    </div>
    <guiceae:footer/>
</div>
</body>
</html>
