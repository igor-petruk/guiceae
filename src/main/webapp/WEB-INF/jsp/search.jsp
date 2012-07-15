<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="guiceae" uri="http://guiceae.org" %>
<html>
    <guiceae:head>
        <script type="text/javascript" src="/js/feed.js"></script>
   </guiceae:head>
    <body>
        <guiceae:menu/>
        
        <div>
            <form action="/app/search" method="get">
                <input name="query" value="${it.query}"/>
                <input type="submit" value="Пошук"/>
            </form>
        </div>
    
        <div>
            <c:forEach var="result" items="${it.results}">
                <guiceae:article shortView="true" article="${result}" simpleDelete="true"/>

            <!--    <a href="/app/article/detail/${result.permalink}"><c:out value="${result.title}"/></a>
                <p>
                    ${result.shortContent}
                </p>    -->
            </c:forEach>
        </div>
    </body>
</html>
