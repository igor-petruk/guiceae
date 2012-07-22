<%@ tag pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="guiceae" uri="http://guiceae.org" %>

<%@ attribute name="pagesCount" required="true" %>
<%@ attribute name="currentFirst" required="true" %>
<%@ attribute name="feed" required="true" type="java.util.List" %>
<%@ attribute name="feedName" required="true" %>

<guiceae:rolesOnly roles="cm">
    <a id="add-article" href="/app/article/add/${feedName}">Додати статтю</a>
</guiceae:rolesOnly>

<div class="feed-full-view">
    <a class="rss" href="/app/feed/${feedName}/rss"><img src="/css/images/system/rss.png"
                                                         alt="Підписатися на оновлення"></a>

    <c:forEach var="article" items="${feed}">
        <guiceae:article shortView="true" article="${article}" simpleDelete="true" social="true"/>
    </c:forEach>


    <%--<guiceae:pagesList feed="${feedName}" pagesCount='${pagesCount}' currentFirst='${currentFirst}'/>--%>

</div>
