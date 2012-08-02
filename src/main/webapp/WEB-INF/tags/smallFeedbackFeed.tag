<%@ tag pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="guiceae" uri="http://guiceae.org" %>

<%@ attribute name="feedName" required="true" %>
<%@ attribute name="feed" required="true" type="java.util.List" %>
<%@ attribute name="isOnMain" type="java.lang.Boolean" %>


<c:choose>
    <c:when test="${isOnMain}">
        <div class="feedback-short-view main">
            <c:forEach var="feedback" items="${feed}">
                <guiceae:feedbackOnMain feedName="${feedName}" feedback="${feedback}"/>
            </c:forEach>
        </div>
    </c:when>
    <c:otherwise>
        <div class="feedback-short-view">
            <c:forEach var="feedback" items="${feed}">
                <guiceae:feedback feedName="${feedName}" feedback="${feedback}"/>
            </c:forEach>
        </div>
    </c:otherwise>
</c:choose>

