<%@ tag pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="guiceae" uri="http://guiceae.org" %>

<%@ attribute name="shortView" required="true" type="java.lang.Boolean" %>
<%@ attribute name="article" required="true" type="org.guiceae.main.model.Article" %>
<%@ attribute name="simpleDelete" required="true" type="java.lang.Boolean" %>

    <div id="article${article.id}">
        <h2><a href="/app/article/detail/${article.permalink}">${article.title}</a></h2>
        <div id="article${article.id}">
            <c:choose>
                <c:when test="${shortView}">
                    <p>
                            ${article.shortContent}
                    </p>
                    <a href="/app/article/detail/${article.permalink}">Читати далі...</a>
                </c:when>
                <c:otherwise>
                    ${article.content}
                </c:otherwise>
            </c:choose>
        </div>
        <div style="float: right;">
            ${article.author}, ${article.created}
        </div>
        <guiceae:rolesOnly roles="cm">
            <div>
                <a href="/app/article/edit/${article.id}">Редагувати</a>
                <a href="#" id="delete${article.id}">Видалити</a>
                <script type="text/javascript">
                    $(function(){
                        <c:choose>
                            <c:when test="${simpleDelete}">
                                registerSimpleDelete("${article.id}","${article.feed}");
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
                        $(function(){
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
    </div>
