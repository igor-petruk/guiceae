<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="guiceae" uri="http://guiceae.org" %>
<html>
    <guiceae:head>
    </guiceae:head>
    <body>
        <guiceae:menu/>
        <p>
            <label for="author">П.І.Б.</label> <br/>
            <input name="author" id="author"/><br/>

            <label for="question">Ваше питання</label> <br/>
            <textarea rows="10" cols="60" id="question" name="question"></textarea>

            <div class="captcha-error" style="display: none;">
                <span style="color: red;">Помилка</span>
            </div>
            <script type="text/javascript">
                var RecaptchaOptions = {
                    theme : 'clean',
                    lang: 'ru'
                };
            </script>
            <script type="text/javascript"
                    src="http://www.google.com/recaptcha/api/challenge?k=${it.publicKey}&error=test">
            </script>
            <noscript>
                <iframe src="http://www.google.com/recaptcha/api/noscript?k=${it.publicKey}"
                        height="300" width="500" frameborder="0"></iframe><br>
                <textarea name="recaptcha_challenge_field" rows="3" cols="40">
                </textarea>
                <input type="hidden" name="recaptcha_response_field"
                       value="manual_challenge">
            </noscript>

            <input id="submit-button" type="button" value="Submit"/>

            <script type="text/javascript">
                $(function(){
                    $("#submit-button").click(function(){
                        var form = {
                            challenge:Recaptcha.get_challenge(),
                            response:Recaptcha.get_response(),
                            question: $("#question").val(),
                            author: $("#author").val()
                        };
                        $.ajax({
                            url:"/app/feedback/submit/${it.feed}",
                            type:"POST",
                            data:JSON.stringify(form),
                            contentType:"application/json; charset=utf-8",
                            dataType:"json",
                            cache:false,
                            success: function(data){
                                setTimeout(function(){
                                    window.location="/app/feedback/view/${it.feed}"
                                },1000);
                            },
                            error: function(jqXHR, textStatus, errorThrown){
                                if (jqXHR.status===401){
                                    $(".captcha-error").css("display","block");
                                    Recaptcha.reload();
                                    Recaptcha.focus_response_field();
                                }
                            }
                        })
                    });
                })
            </script>
        </p>
    </body>
</html>
