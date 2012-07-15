<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="guiceae" uri="http://guiceae.org" %>
<html>
    <guiceae:head>
        <script type="text/javascript" src="/js/feed.js"></script>
        <LINK REL="alternate" TITLE="${it.feedName} RSS"
              HREF="/app/feed/${it.feedName}/rss"
              TYPE="application/rss+xml">
    </guiceae:head>
    <body>
        <guiceae:menu/>

        <guiceae:feed shortView="true" currentFirst="0" pagesCount="10"/>
    </body>
</html>
