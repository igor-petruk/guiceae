<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="guiceae" uri="http://guiceae.org" %>
<html>
    <guiceae:head>
        <script type="text/javascript" src="/js/feed.js"></script>
        <LINK REL="alternate" TITLE="${it.feedName} RSS"
              HREF="/app/feed/${it.feedName}/rss"
              TYPE="application/rss+xml">
    </guiceae:head>
    <body>
        <guiceae:menu/>
        <p>
            <c:forEach var="question" items="${it.feed}">
                <div>
                    <p>
                        ${question.question}
                    </p>
                    <p>
                       <span style="font-style: italic;">${question.answer}</span>
                    </p>
                </div>
                <div style="float: right;">
                        ${question.author}, ${question.created}
                </div>
        <guiceae:rolesOnly roles="cm">
            <div>
                 <a href="/app/feedback/edit/${question.id}">Редагувати</a>
                 <c:if test="${question.state=='PENDING'}">
                    Питання <b>не опубліковане</b>
                    <a href="#" id="publish${question.id}">Опублікувати</a>
                     <a href="#" id="delete${question.id}">Видалити</a>
                     <script type="text/javascript">
                        $(function(){
                            registerPublishQuestion("${question.id}");
                            registerSimpleFeedbackDelete("${question.id}", "${question.feed}".toLowerCase());
                        });
                    </script>
                </c:if>
            </div>
        </guiceae:rolesOnly>

            </c:forEach>
        </p>
    </body>
</html>