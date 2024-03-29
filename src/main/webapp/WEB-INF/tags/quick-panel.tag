<%@ tag pageEncoding="UTF-8" %>
<%@ attribute name="query" type="java.lang.String" %>

<p class="search">

<div class="inputs">
    <span><img style="width:20px;" src="/css/images/system/search.png" title="Пошук"/></span>

    <form action="/app/search" method="get" style="display: inline;">
        <input name="query" type="text" class="txt" value="${query}" id="query"/>
        <input type="submit" class="btn" value="Знайти" id="submit-query"/>
    </form>
</div>

<div class="login">
    <ul>
        <li><span><a href="/app/index">Головна</a></span><a href="/app/index">
            <img src="/css/images/system/home.png" title="Перейти на головну" height="64" width="64"/></a></li>

        <li><span><a href="/app/feedback/submit/question">Задати питання</a></span><a
                href="/app/feedback/submit/question">
            <img src="/css/images/system/question.png" title="Задати питання" height="64" width="64"/></a></li>

        <li><span><a href="/app/feedback/submit/comment">Лишити відгук</a></span><a href="/app/feedback/submit/comment">
            <img src="/css/images/system/note_write.png" title="Задати питання" height="64" width="64"/></a></li>
    </ul>
</div>
</p>