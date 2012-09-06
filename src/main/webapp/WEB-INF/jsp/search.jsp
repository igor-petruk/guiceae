<!DOCTYPE HTML PUBLIC "-//W3//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="guiceae" uri="http://guiceae.org" %>
<html>
<guiceae:head>
    <title>Пошук</title>
    <script type="text/javascript" src="/js/feed.js"></script>
</guiceae:head>
<guiceae:body>

    <div id="head">
        <guiceae:quick-panel query="${it.query}"/>
    </div>

    <div id="personal-not-main">
        <div class="name">Персональний сайт Івана Куровського</div>
        <div class="background"><img src="/css/images/system/personal_not_main.png"/></div>
        <div class="sub-label">Пошук</div>
    </div>

    <guiceae:new-menu/>


    <div id="content">
        <div id="content_cen">
            <div id="content_sup">

                <div class="view-center-place">
                    <span class="title">Результати пошуку за запитом "${it.query}" ↓</span>

                    <div class="results">
                        <c:forEach var="result" items="${it.results}">
                            <guiceae:article shortView="true" article="${result}" simpleDelete="true"/>
                        </c:forEach>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <guiceae:footer/>
</guiceae:body>
</html>
