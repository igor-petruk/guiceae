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
        <li><span>Написати</span><a href="#"><img src="/css/images/system/letter.png" title="Написати листа" height="64"
                                                  width="64"/></a>
        </li>
        <li><span>Задати питання</span><a href="#"><img src="/css/images/system/question.png" title="Задати питання"
                                                        height="64"
                                                        width="64"/></a></li>
    </ul>
</div>
</p>