<%@ tag pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="guiceae" uri="http://guiceae.org" %>

<%@ attribute name="feedback" required="true" type="org.guiceae.main.model.Feedback" %>
<%@ attribute name="feedName" required="true" type="java.lang.String" %>
<%@ attribute name="simpleDelete" required="true" type="java.lang.Boolean" %>


<div class="feedback" id="feedback${feedback.id}">

    <div class="question">
        ${feedback.question}
    </div>

    <div class="author">
        ${feedback.author}
    </div>

    <div class="createdDate">
        <fmt:formatDate value="${feedback.created}" pattern="dd/MM/yyyy hh:mm"/>
    </div>

    <div class="answer">
        ${feedback.answer}
    </div>

    <div class="separator"></div>
</div>


<guiceae:rolesOnly roles="cm">
    <div class="admin-feedback">
        <a href="/app/feedback/edit/${feedback.id}">Редагувати</a>
        <a href="#" id="delete${feedback.id}">Видалити</a>
        <script type="text/javascript">
            $(function () {
                <c:choose>
                <c:when test="${simpleDelete}">
                registerSimpleDelete("${feedback.id}", "${feedback.feed}");
                </c:when>
                <c:otherwise>
                registerDelete("${feedback.id}");
                </c:otherwise>
                </c:choose>
            });
        </script>
        <c:if test="${feedback.state=='PENDING'}">
            Стаття <b>не опублікована</b>
            <a href="#" id="publish${feedback.id}">Опублікувати</a>
            <script type="text/javascript">
                $(function () {
                    registerPublish("${feedback.id}");
                });
            </script>
        </c:if>

        <button id="edit${feedback.id}">Edit</button>

        <script type="text/javascript">
            $("#edit${feedback.id}").button().click(function () {
                var content = $("#feedback${feedback.id}");
                var contentHtml = content.html();
                content.html("");
                var ta = $("<textarea/>").attr("id", "textarea${feedback.id}").text(contentHtml);
                ta.appendTo(content);
                CKEDITOR.replace('textarea${feedback.id}',
                        {
                            toolbar:'Basic',
                            uiColor:'#9AB8F3'
                        });
                $("#edit${feedback.id}").hide();
            })
        </script>
        -->
    </div>
</guiceae:rolesOnly>
