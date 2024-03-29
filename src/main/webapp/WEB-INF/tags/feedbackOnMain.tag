<%@ tag pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="guiceae" uri="http://guiceae.org" %>

<%@ attribute name="feedback" required="true" type="org.guiceae.main.model.Feedback" %>
<%@ attribute name="feedName" required="true" type="java.lang.String" %>

<div class="feedback" id="feedback${feedback.id}">

    <div class="question main" id="feedbackq${feedback.id}">
        <p>${feedback.question}</p>
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

    <div class="author main">
        ${feedback.author}
    </div>

    <div class="createdDate main">
        <fmt:formatDate value="${feedback.created}" pattern="dd/MM/yyyy hh:mm"/>
    </div>

    <div class="answer main" id="answerq${feedback.id}">
        <p>
            ${feedback.answer}
        </p>
    </div>


    <div class="separator main"></div>
</div>
<script type="text/javascript">
    $(function () {
        $("div.question.main").expander({
            slicePoint:200, // default is 10
            expandText:'[далі]', // default is 'read more'
            userCollapseText:'[згорнути]'  // default is 'read less'
        });

        $("div.answer.main").expander({
            slicePoint:200, // default is 10
            expandText:'[далі]', // default is 'read more'
            userCollapseText:'[згорнути]'  // default is 'read less'
        });
    });
</script>


