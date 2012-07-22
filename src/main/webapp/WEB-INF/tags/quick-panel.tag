<%@ tag pageEncoding="UTF-8" %>

<p class="search">

<div class="inputs">
    <span>Пошук</span>

    <form action="/app/search" method="get" style="display: inline;">
        <input name="query" type="text" class="txt" value="${it.query}"/>
        <input type="submit" class="btn" value="Знайти"/>
    </form>
</div>

<div class="login">
    <ul>
        <li><span>Головна</span><a href="/app/index"><img src="/css/images/system/home.png" title="Перейти на головну"
                                                          height="64"
                                                          width="64"/></a></li>
        <li><span>Задати питання</span><a href="/app/feedback/submit/question"><img
                src="/css/images/system/question.png" title="Задати питання"
                height="64"
                width="64"/></a></li>
        <li><span>Лишити побажання</span><a href="/app/feedback/submit/comment"><img
                src="/css/images/system/note_write.png" title="Задати питання"
                height="64"
                width="64"/></a></li>
    </ul>
</div>
</p>