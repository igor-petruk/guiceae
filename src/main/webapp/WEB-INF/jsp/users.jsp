<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="guiceae" uri="http://guiceae.org" %>
<html>
    <guiceae:head/>
    <body>
        <guiceae:menu/>

        <ul>
            <c:forEach var="userRole" items="${it}">
                <li>
                    <div><c:out value="${userRole.userId}"/></div>
                    <div><c:out value="${userRole.rolesString}"/></div>
                </li>
            </c:forEach>
        </ul>

    </body>
</html>
