<!DOCTYPE HTML PUBLIC "-//W3//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<%--
  User: boui
  Date: 7/12/12
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="guiceae" uri="http://guiceae.org" %>

<html>
<guiceae:head>

</guiceae:head>
<body>

<div id="head">

    <guiceae:quick-panel/>

    <div id="personal">
        <div class="name">Іван Куровський</div>
        <div class="sub-label">Персональний сайт</div>
    </div>
</div>

<guiceae:new-menu/>
<div id="content">
    <div id="content_cen">
        <div id="content_sup">

            <div class="left-place feedbackQuestion">
                <span id="left-label">${it.proposition} ↓</span>

                <div class="question-place">
                    <label for="author">Ваше ім'я: </label>
                    <input name="author" id="author" type="text"/>

                    <label for="question">Ваше питання: </label>
                    <textarea rows="10" cols="54" id="question" name="question" max-length="1000"></textarea>

                    <div class="captcha-error" style="display: none;">
                        <span style="color: red;">Помилка</span>
                    </div>


                    <script type="text/javascript">
                        var RecaptchaOptions = {
                            theme:'clean',
                            lang:'ru'
                        };
                    </script>
                    <script type="text/javascript"
                            src="http://www.google.com/recaptcha/api/challenge?k=${it.publicKey}&error=test">
                    </script>

                    <noscript>
                        <iframe src="http://www.google.com/recaptcha/api/noscript?k=${it.publicKey}"
                                height="300" width="500" frameborder="0"></iframe>
                        <br>
                        <textarea name="recaptcha_challenge_field" rows="3" cols="40">
                        </textarea>
                        <input type="hidden" name="recaptcha_response_field"
                               value="manual_challenge">
                    </noscript>

                    <input id="submit-button" type="button" value="Submit"/>

                    <script type="text/javascript">
                        $(function () {
                            $("#submit-button").click(function () {
                                var form = {
                                    challenge:Recaptcha.get_challenge(),
                                    response:Recaptcha.get_response(),
                                    question:$("#question").val(),
                                    author:$("#author").val()
                                };
                                $.ajax({
                                    url:"/app/feedback/submit/${it.feed}",
                                    type:"POST",
                                    data:JSON.stringify(form),
                                    contentType:"application/json; charset=utf-8",
                                    dataType:"json",
                                    cache:false,
                                    success:function (data) {
                                        setTimeout(function () {
                                            window.location = "/app/feedback/view/${it.feed}"
                                        }, 1000);
                                    },
                                    error:function (jqXHR, textStatus, errorThrown) {
                                        if (jqXHR.status === 401) {
                                            $(".captcha-error").css("display", "block");
                                            Recaptcha.reload();
                                            Recaptcha.focus_response_field();
                                        }
                                    }
                                })
                            });
                        })
                    </script>
                </div>
            </div>

            <div class="view-right-place feedbackQuestion">
                <span>${it.theme} ↓</span>
                <guiceae:smallFeedbackFeed feedName="${it.feed}" feed="${it.feedbacks}"/>
            </div

        </div>
    </div>
</div>

<guiceae:footer/>
</body>
</html>