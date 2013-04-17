<%@ tag pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="guiceae" uri="http://guiceae.org" %>

<%@ attribute name="article" required="true" type="org.guiceae.main.model.Article" %>
<%@ attribute name="simpleDelete" required="true" type="java.lang.Boolean" %>
<%@ attribute name="social" type="java.lang.Boolean" %>
<%@ attribute name="feedName" type="java.lang.String" %>

<div class="article" id="article${article.id}">

    <guiceae:rolesOnly roles="cm">
        <div class="admin">
            <a href="/app/article/edit/${article.id}">Редагувати</a>
            <a href="#" id="delete${article.id}">Видалити</a>
            <c:if test="${article.state=='PENDING'}">
                Стаття <b>не опублікована</b>
                <a href="#" id="publish${article.id}">Опублікувати</a>
                <script type="text/javascript">
                    $(function () {
                        registerPublish("${article.id}");
                    });
                </script>
            </c:if>
            <script type="text/javascript">
                $(function () {
                    <c:choose>
                    <c:when test="${simpleDelete}">
                    registerSimpleDelete("${article.id}", "${article.feed}");
                    </c:when>
                    <c:otherwise>
                    registerDelete("${article.id}");
                    </c:otherwise>
                    </c:choose>
                });
            </script>
        </div>
    </guiceae:rolesOnly>

    <div style="float: right; margin-right: 1px;">
        <c:if test="${social}">
            <span><guiceae:vkontakte article="${article}"/></span>
            <span><guiceae:twitter article="${article}"/></span>
            <span><guiceae:facebook article="${article}"/></span>
        </c:if>
    </div>

    <div class="short-content shortArticle" style="background-color: #">
        <c:if test="${article.mainPhotoUrl!=null && article.mainPhotoUrl!=''}">
            <img class="mainPhoto" src="${article.mainPhotoUrl}=s100"/>
        </c:if>
        ${article.shortContent}
    </div>
    <div style="clear: both;"></div>

</div>

