<!DOCTYPE HTML PUBLIC "-//W3//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<%--
  User: boui
  Date: 7/12/12
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="guiceae" uri="http://guiceae.org" %>
<html>
<guiceae:head>
    <script type="text/javascript" src="/js/feed.js"></script>
    <script type="text/javascript">
        $(function () {
            effectOnArrow();
        });
    </script>
    <LINK REL="alternate" TITLE="${it.feedName} RSS"
          HREF="/app/feed/${it.feedName}/rss"
          TYPE="application/rss+xml">

</guiceae:head>
<guiceae:body>

    <div id="head">
        <guiceae:quick-panel/>
    </div>

    <div id="personal-not-main">
        <div class="name">Персональний сайт Івана Куровського</div>
        <div class="background"><img src="/css/images/system/personal_not_main.png"/></div>

        <div class="sub-label"><span id="funny-arrow" style="float:left; margin:2px 10px 0 0;"><img
                src="/css/images/main/arrow.png"/></span>
            <span style="float:left;">${it.feedsNames[it.feedName]}</span></div>
    </div>

    <guiceae:new-menu/>


    <div id="content">
        <div id="content_cen">
            <div id="content_sup">

                <div class="left-place">
                    <span id="functional-propose">Оберіть стрічку новин ↓</span>

                    <c:forEach items="${it.feedsNames}" var="feed">

                        <c:choose>
                            <c:when test="${feed.key == it.feedName}">
                                <c:set var="activate" value="active"/>
                            </c:when>
                            <c:otherwise>
                                <c:set var="activate" value=""/>
                            </c:otherwise>
                        </c:choose>
                        <div class="feed-name ${activate}">
                            <a href="/app/feed/${feed.key}">${feed.value}</a>
                        </div>

                    </c:forEach>
                    <guiceae:rolesOnly roles="cm">
                        <c:forEach items="${it.adminFeeds}" var="feed">
                            <div class="feed-name">
                                <a href="/app/feed/${feed.key}">${feed.value}</a>
                            </div>
                        </c:forEach>
                    </guiceae:rolesOnly>
                </div>

                <div class="view-right-place">
                    <guiceae:feed feedName="${it.feedName}" feed="${it.feed}" currentFirst="${it.currentFirst}"
                                  pagesCount="${it.pagesCount}"/>
                </div>

            </div>
        </div>
    </div>

    <guiceae:footer/>
</guiceae:body>
</html>
