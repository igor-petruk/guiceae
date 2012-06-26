<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="guiceae" uri="http://guiceae.org" %>
<html>
    <guiceae:head/>
    <body>
        <guiceae:menu/>

        <ul>
            <c:forEach var="message" items="${it.messages}">
                <li>
                    <div><c:out value="${message.text}"/></div>
                    <div><a href="index/deleteitem/<c:out value="${message.id}"/>">Delete</a></div>
                </li>
            </c:forEach>
        </ul>

        <form action="index/addmessage" method="post">
            <input name="text"/>
            <input type="submit"/>
        </form>
    </body>
</html>
