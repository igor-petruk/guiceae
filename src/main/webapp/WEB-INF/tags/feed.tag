<%@ tag pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="guiceae" uri="http://guiceae.org" %>

<%@ attribute name="shortView" required="true" type="java.lang.Boolean" %>
<%@ attribute name="pagesCount" required="true" %>
<%@ attribute name="currentFirst" required="true" %>
<%@ attribute name="feed" required="true" type="java.util.List" %>
<%@ attribute name="feedName" required="true" %>

<div class="feed-full-view">

    <guiceae:rolesOnly roles="cm">
        <a id="add-article" href="/app/article/add/${feedName}">Додати статтю</a>
    </guiceae:rolesOnly>
    <p>
        <a href="/app/feed/${feedName}/rss"><img src="/css/images/system/rss.png" alt="Підписатися на оновлення"></a>
    </p>

    <c:forEach var="article" items="${feed}">
        <guiceae:article shortView="${shortView}" article="${article}" simpleDelete="true"/>
    </c:forEach>


</div>

<guiceae:pagesList feed="${feedName}" pagesCount='${pagesCount}' currentFirst='${currentFirst}'/>

