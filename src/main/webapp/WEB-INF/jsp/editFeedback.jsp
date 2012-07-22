<!DOCTYPE HTML PUBLIC "-//W3//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="guiceae" uri="http://guiceae.org" %>
<html>
<guiceae:head>
</guiceae:head>
<body>

<div>
    <form action="/app/feedback/save" method="post">
        <input name="id" type="hidden" value="${it.id}"/>
        <input name="feed" type="hidden" value="<c:out value='${it.feed}'/>"/>

        <label for="author">Автор</label>
        <input id="author" name="author" value="<c:out value='${it.author}'/>"/>

        <label for="question">Питання</label>
        <textarea id="question" name="question">
            ${it.question}
        </textarea>

        <label for="answer">Відповідь</label>
        <textarea id="answer" name="answer">
            ${it.answer}
        </textarea>

        <input type="submit"/>

    </form>
</div>
</body>
</html>
