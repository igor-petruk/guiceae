<%@ tag pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="guiceae" uri="http://guiceae.org" %>

<%@ attribute name="feedName" required="true" %>
<%@ attribute name="feed" required="true" type="java.util.List" %>

<div class="feedback-short-view">
    <c:forEach var="feedback" items="${feed}">
        <guiceae:feedback feedName="${feedName}" feedback="${feedback}" simpleDelete="true"/>
    </c:forEach>
</div>
