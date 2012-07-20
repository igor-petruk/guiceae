<%@ tag pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="guiceae" uri="http://guiceae.org" %>
<%@ attribute name="shortView" required="true" type="java.lang.Boolean" %>
<%@ attribute name="article" required="true" type="org.guiceae.main.model.Article" %>
<%@ attribute name="simpleDelete" required="true" type="java.lang.Boolean" %>


<div class="article" id="article${article.id}">

    <div class="title">
        <a href="/app/article/detail/${article.permalink}">${article.title}</a>
    </div>

    <%--<div class="author">--%>
    <%--${article.author}--%>
    <%--</div>--%>

    <div class="createdDate">
        <fmt:formatDate value="${article.created}" pattern="dd/MM/yyyy HH:mm"></fmt:formatDate>
    </div>

    <c:choose>
        <c:when test="${article.mainPhotoUrl}">
            <span class="mainPhoto">
            <img src="${article.mainPhotoUrl}=s200"/>
            </span>

            <div class="short-content _70">
                    ${article.shortContent}
            </div>
        </c:when>
        <c:otherwise>
            <div class="short-content _100">
                    ${article.shortContent}
            </div>
        </c:otherwise>
    </c:choose>


    <div class="more-div">
        <a class="more" href="/app/article/detail/${article.permalink}">Далі...</a>
    </div>

    <c:if test="${!shortView}">
        <div class="long-content">
                ${article.content}
        </div>
    </c:if>
    <div class="separator"></div>
</div>

<guiceae:rolesOnly roles="cm">
    <div>
        <a href="/app/article/edit/${article.id}">Редагувати</a>
        <a href="#" id="delete${article.id}">Видалити</a>
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
        <c:if test="${article.state=='PENDING'}">
            Стаття <b>не опублікована</b>
            <a href="#" id="publish${article.id}">Опублікувати</a>
            <script type="text/javascript">
                $(function () {
                    registerPublish("${article.id}");
                });
            </script>
        </c:if>

        <!-- <button id="edit${article.id}">Edit</button>

<script type="text/javascript">
$("#edit${article.id}").button().click(function(){
var content = $("#article${article.id}");
var contentHtml = content.html();
content.html("");
var ta = $("<textarea/>").attr("id","textarea${article.id}").text(contentHtml);
ta.appendTo(content);
CKEDITOR.replace( 'textarea${article.id}',
{
toolbar : 'Basic',
uiColor : '#9AB8F3'
});
$("#edit${article.id}").hide();
})
</script> -->
    </div>
</guiceae:rolesOnly>
