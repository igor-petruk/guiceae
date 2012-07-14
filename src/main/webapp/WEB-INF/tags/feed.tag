<%@ tag pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="guiceae" uri="http://guiceae.org" %>

<guiceae:rolesOnly roles="cm">
    <p>
        <a href="/app/article/add/${it.feedName}">Add article</a>
    </p>
</guiceae:rolesOnly>

<c:forEach var="article" items="${it.feed}">
    <guiceae:article article="${article}"/>
</c:forEach> 