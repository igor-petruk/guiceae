<%@ tag pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="guiceae" uri="http://guiceae.org" %>
<%@ attribute name="article" required="true" type="org.guiceae.main.model.Article" %>

<c:url value="https://twitter.com/share" var="twitterUrl">
    <c:param name="text" value="${article.title}"/>
    <c:param name="url" value="http://${siteUrl}app/article/detail/${article.permalink}"/>
</c:url>
<a href="${twitterUrl}" class="twitter-share-button" target="_blank"><img src="/css/images/tweet.png"/></a>
