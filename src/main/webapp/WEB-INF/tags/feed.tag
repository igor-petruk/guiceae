<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="guiceae" uri="http://guiceae.org" %>

<p>
<a href="/app/article/add/${it.feedName}">Add article</a>
</p>

<c:forEach var="article" items="${it.feed}">
    <guiceae:article article="${article}"/>
</c:forEach> 