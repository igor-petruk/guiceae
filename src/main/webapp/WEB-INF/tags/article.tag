<%@ tag pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="guiceae" uri="http://guiceae.org" %>
<%@ attribute name="shortView" required="true" type="java.lang.Boolean" %>
<%@ attribute name="article" required="true" type="org.guiceae.main.model.Article" %>
<%@ attribute name="simpleDelete" required="true" type="java.lang.Boolean" %>
<%@ attribute name="social" type="java.lang.Boolean" %>

<div class="article" id="article${article.id}">

    <div class="title">
        <a href="/app/article/detail/${article.permalink}">${article.title}</a>
    </div>


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

    <div class="createdDate">
        <c:if test="${social}">
            <guiceae:twitter article="${article}"/>
            <guiceae:vkontakte article="${article}"/>
        </c:if>
        <span><fmt:formatDate value="${article.created}" pattern="dd/MM/yyyy HH:mm"></fmt:formatDate></span>
    </div>

    <c:choose>
        <c:when test="${article.mainPhotoUrl!=null}">
            <span class="mainPhoto">
            <img src="${article.mainPhotoUrl}=s100"/>
            </span>

            <div class="short-content _70">
                    ${article.shortContent}
            </div>

            <div class="more-div">
                <a class="more" href="/app/article/detail/${article.permalink}">Далі...</a>
            </div>

        </c:when>
        <c:otherwise>
            <div class="short-content _100">
                    ${article.shortContent}
            </div>
        </c:otherwise>
    </c:choose>

    <c:if test="${!shortView}">
        <div class="long-content">
                ${article.content}
        </div>
    </c:if>
    <div class="separator"></div>
</div>

