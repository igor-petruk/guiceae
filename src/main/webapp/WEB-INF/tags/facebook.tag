<%@ tag pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="guiceae" uri="http://guiceae.org" %>
<%@ attribute name="article" required="true" type="org.guiceae.main.model.Article" %>

<c:url value="http://www.facebook.com/sharer.php" var="facebookUrl">
    <c:param name="t" value="${article.title}"/>
    <c:param name="u" value="http://${siteUrl}app/article/detail/${article.permalink}"/>
</c:url>
<a href="${facebookUrl}" target="_blank"><img src="/css/images/facebook.png"/></a>
