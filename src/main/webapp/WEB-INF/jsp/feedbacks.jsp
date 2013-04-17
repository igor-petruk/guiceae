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
    <script type="text/javascript" src="/js/feed.js"></script>
    <title>${it.theme}</title>
</guiceae:head>
<guiceae:body>
    <div id="head">
        <guiceae:quick-panel/>
    </div>

    <div id="personal-not-main">
        <div class="name">Персональний сайт Івана Куровського</div>
        <div class="background">
            <img src="/css/images/system/personal_not_main.png"/>
        </div>

        <div class="sub-label"><span id="funny-arrow" style="float:left; margin:2px 10px 0 0;"><img
                src="/css/images/main/arrow.png"/></span>
            <span style="float:left;">${it.theme}</span></div>
    </div>

    <guiceae:new-menu/>
    <div id="content">
        <div id="content_cen">
            <div id="content_sup">

                <div class="left-place feedbackQuestion">
                    <span id="functional-propose">${it.proposition} ↓</span>

                    <div class="question-place">
                        <label for="author">Ваше ім'я: </label>
                        <input name="author" id="author" type="text"/>

                        <label for="question">${it.proposition_area}</label>
                        <textarea rows="10" cols="45" id="question" name="question" max-length="1000"></textarea>

                        <div class="captcha-error" style="display: none;">
                            <span style="color: red;">Помилка</span>
                        </div>
                        <div id="alerts"></div>


                        <script type="text/javascript">
                            var RecaptchaOptions = {
                                theme: 'blackglass',
                                lang: 'ru'
                            };
                        </script>
                        <div align="center">
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

                            <input id="submit-button" type="button" value="Відправити на розгляд"/>
                        </div>


                        <script type="text/javascript">
                            $(function () {

                                effectOnArrow();
                                $("#submit-button").click(function () {
                                    var form = {
                                        challenge: Recaptcha.get_challenge(),
                                        response: Recaptcha.get_response(),
                                        question: $("#question").val(),
                                        author: $("#author").val()
                                    };
                                    $.ajax({
                                        url: "/app/feedback/submit/${it.feed}",
                                        type: "POST",
                                        data: JSON.stringify(form),
                                        contentType: "application/json; charset=utf-8",
                                        dataType: "json",
                                        cache: false,
                                        success: function (data) {
                                            var t = ("${it.feed}" == 'question') ? "Ваше питання" : "Ваш відгук";
                                            $("#alerts").html(t + " відправлено на розгляд." +
                                                    "Після розгляду, ви зможете побачити відповідь у розділі Громадська Приймальня.");

                                            $("#alerts:ui-dialog").dialog("destroy");

                                            $("#alerts").dialog({
                                                modal: true,
                                                buttons: {
                                                    Ok: function () {
                                                        $(this).dialog("close").effect("drop");
                                                        window.location = "/app/feedback/submit/${it.feed}";
                                                    }
                                                }
                                            });


                                        },
                                        error: function (jqXHR, textStatus, errorThrown) {
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
                        <%--<span id="theme">${it.theme} ↓</span>--%>
                    <guiceae:smallFeedbackFeed feedName="${it.feed}" feed="${it.feedbacks}"/>
                </div

            </div>
        </div>
    </div>

    <guiceae:footer/>
</guiceae:body>
</html>