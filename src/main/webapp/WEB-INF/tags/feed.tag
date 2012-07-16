<%@ tag pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="guiceae" uri="http://guiceae.org" %>

<%@ attribute name="shortView" required="true" type="java.lang.Boolean"%>
<%@ attribute name="pagesCount" required="true"%>
<%@ attribute name="currentFirst" required="true"%>
<%@ attribute name="feed" required="true"  type="java.util.List" %>
<%@ attribute name="feedName" required="true"%>

<p>
    <a href="/app/feed/${feedName}/rss">RSS</a>
</p>

<guiceae:rolesOnly roles="cm">
    <p>
        <a href="/app/article/add/${feedName}">Додати статтю</a>
    </p>
</guiceae:rolesOnly>

<c:forEach var="article" items="${feed}">
    <guiceae:article shortView="${shortView}" article="${article}"  simpleDelete="true"/>
</c:forEach>

<guiceae:pagesList feed="${feedName}" pagesCount='${pagesCount}' currentFirst='${currentFirst}'/>

