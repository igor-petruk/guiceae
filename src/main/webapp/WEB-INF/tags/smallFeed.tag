<%@ tag pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="guiceae" uri="http://guiceae.org" %>

<%@ attribute name="feedName" required="true" %>
<%@ attribute name="feed" required="true" type="java.util.List" %>

<div class="feed-short-view">
    <c:forEach var="article" items="${feed}">
        <guiceae:article shortView="true" article="${article}" simpleDelete="true" social="false"
                         feedName="${feedName}"/>
    </c:forEach>
</div>
