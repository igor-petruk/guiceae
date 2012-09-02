<%@ tag pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="guiceae" uri="http://guiceae.org" %>

<%@ attribute name="feedback" required="true" type="org.guiceae.main.model.Feedback" %>
<%@ attribute name="feedName" required="true" type="java.lang.String" %>

<div class="feedback" id="feedback${feedback.id}">
    <div class="question">
        ${feedback.question}
    </div>

    <guiceae:rolesOnly roles="cm">
        <div class="admin">
            <a href="/app/feedback/edit/${feedback.id}">Редагувати</a>
            <a href="#" id="delete${feedback.id}">Видалити</a>
            <script type="text/javascript">
                $(function () {
                    registerSimpleFeedbackDelete("${feedback.id}", "${feedback.feed}");
                });
            </script>
            <c:if test="${feedback.state=='PENDING'}">
                Стаття <b>не опублікована</b>
                <a href="#" id="publish${feedback.id}">Опублікувати</a>
                <script type="text/javascript">
                    $(function () {
                        registerPublishQuestion("${feedback.id}");
                    });
                </script>
            </c:if>

        </div>
    </guiceae:rolesOnly>

    <div class="author">
        ${feedback.author}
    </div>

    <div class="createdDate">
        <fmt:formatDate value="${feedback.created}" pattern="dd/MM/yyyy hh:mm"/>
    </div>

    <div class="answer">
        ${feedback.answer}
    </div>
</div>
<script type="text/javascript">
    $(function () {
        $("div.question").expander({
            slicePoint:500, // default is 10
            expandText:'[далі]', // default is 'read more'
            collapseTimer:5000, // re-collapses after 5 seconds; default is 0, so no re-collapsing
            userCollapseText:'[згорнути]'  // default is 'read less'
        });

        $("div.answer").expander({
            slicePoint:500, // default is 10
            expandText:'[далі]', // default is 'read more'
            collapseTimer:5000, // re-collapses after 5 seconds; default is 0, so no re-collapsing
            userCollapseText:'[згорнути]'  // default is 'read less'
        });
    });
</script>

