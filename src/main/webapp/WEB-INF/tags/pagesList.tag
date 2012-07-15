<%@tag description="put the tag description here" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>

<%-- The list of normal or fragment attributes can be specified here: --%>
<%@attribute name="pagesCount"%>
<%@attribute name="currentFirst"%>
<%@attribute name="feed"%>

<c:if test="${pagesCount>1}">
    <c:forEach begin="1" end='${pagesCount}' var="k">
				<c:set  var="first" value="${(k-1)*5}"/>

				<c:if test="${first==currentFirst}">
					<c:out value="${k}"/>
				</c:if>
				<c:if test="${first!=currentFirst}">
					<a href='/app/feed/${feed}?offset=<c:out value="${first}"/>'><c:out value="${k}"/></a>
				</c:if>
    </c:forEach>
</c:if>