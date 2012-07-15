<%@ tag pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="guiceae" uri="http://guiceae.org" %>

<%@ attribute name="shortView" required="true" type="java.lang.Boolean"%>
<%@ attribute name="pagesCount" required="true"%>
<%@ attribute name="currentFirst" required="true"%>

<p>
    <a href="/app/feed/${it.feedName}/rss">RSS</a>
</p>

<guiceae:rolesOnly roles="cm">
    <p>
        <a href="/app/article/add/${it.feedName}">Додати статтю</a>
    </p>
</guiceae:rolesOnly>

<c:forEach var="article" items="${it.feed}">
    <guiceae:article shortView="${shortView}" article="${article}"  simpleDelete="true"/>
</c:forEach>

<guiceae:pagesList feed="${it.feedName}" pagesCount='${it.pagesCount}' currentFirst='${it.currentFirst}'/>

