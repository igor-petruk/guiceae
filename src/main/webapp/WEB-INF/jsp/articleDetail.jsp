<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="guiceae" uri="http://guiceae.org" %>
<html>
    <guiceae:head>
        <script type="text/javascript" src="/js/feed.js"></script>
    </guiceae:head>
    <body>
        <guiceae:menu/>

        <div>
            <a href="/app/feed/${it.feed}">Назад</a>

            <guiceae:article shortView="false" simpleDelete="true" article="${it}"/>
        </div>
    </body>
</html>
