<%@ tag pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="guiceae" uri="http://guiceae.org" %>
<%@ attribute name="shortView" required="true" type="java.lang.Boolean" %>
<%@ attribute name="article" required="true" type="org.guiceae.main.model.Article" %>
<%@ attribute name="simpleDelete" required="true" type="java.lang.Boolean" %>
<%@ attribute name="social" type="java.lang.Boolean" %>
<%@ attribute name="feedName" type="java.lang.String" %>

<div class="article" id="article${article.id}">

    <c:if test="${feedName != 'mainfeed'}">
        <div class="title">
            <a href="/app/article/detail/${article.permalink}">${article.title}</a>
        </div>
    </c:if>


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
        <c:if test="${feedName != 'mainfeed'}">
            <div class="createdDate">
                <span class="admin">Дата створення</span>
            <span class="admin"><fmt:formatDate value="${article.created}"
                                                pattern="dd/MM/yyyy HH:mm"></fmt:formatDate></span>
                <span class="admin">Дата останнього оновлення</span>
            <span class="admin"><fmt:formatDate value="${article.lastUpdated}"
                                                pattern="dd/MM/yyyy HH:mm"></fmt:formatDate></span>
            </div>
        </c:if>
    </guiceae:rolesOnly>

    <c:if test="${feedName != 'mainfeed'}">
        <div class="createdDate">
        <span style="margin-right: 20px; "><fmt:formatDate value="${article.toView}"
                                                           pattern="dd/MM/yyyy"></fmt:formatDate></span>
            <c:if test="${social}">
                <span><guiceae:vkontakte article="${article}"/></span>
                <span><guiceae:twitter article="${article}"/></span>
                <span><guiceae:facebook article="${article}"/></span>
            </c:if>
        </div>
    </c:if>


    <c:choose>
        <c:when test="${shortView}">
            <div class="short-content _100">
                <c:if test="${article.mainPhotoUrl!=null && article.mainPhotoUrl!=''}">
                    <img class="mainPhoto" src="${article.mainPhotoUrl}=s100"/>
                </c:if>
                    ${article.shortContent}
            </div>
            <div style="clear: both;"></div>
            <c:if test="${feedName != 'mainfeed'}">
                <div class="more-div">
                    <a class="more" href="/app/article/detail/${article.permalink}">Далі...</a>
                </div>
                <div class="separator"></div>
            </c:if>
        </c:when>
        <c:otherwise>
            <div class="short-content _100">
                <c:if test="${article.mainPhotoUrl!=null && article.mainPhotoUrl!=''}">
                    <img class="mainPhoto" src="${article.mainPhotoUrl}=s400"/>
                </c:if>
                    ${article.shortContent}<br/>
                    ${article.content}
            </div>
            <div style="clear: both;"></div>
        </c:otherwise>
    </c:choose>
</div>

