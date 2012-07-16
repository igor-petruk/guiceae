<%@ tag pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="guiceae" uri="http://guiceae.org" %>

<%@ attribute name="feedName" required="true"%>
<%@ attribute name="feed" required="true" type="java.util.List" %>

<p>
    <a href="/app/feed/${feedName}/rss">RSS</a>
</p>

<c:forEach var="article" items="${feed}">
    <h2><a href="/app/article/detail/${article.permalink}">${article.title}</a></h2>
    <div id="article${article.id}">
        <p>
                ${article.shortContent}
        </p>
        <a href="/app/article/detail/${article.permalink}">Читати далі...</a>
    </div>
    <div style="float: right;">
            ${article.author}, ${article.created}
    </div>

</c:forEach>

