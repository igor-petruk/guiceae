<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="guiceae" uri="http://guiceae.org" %>

<html>

<guiceae:head>
    <script type="text/javascript">
        $(function () {
            $("div.menu a").each(function () {
                $(this).append($("#pic").html());
                $(this).children("div").css("margin-left", $(this).position().left - 30 + "px");

                var config = {
                    over:function () {
                        if (!$(this).hasClass("activeMenuItem")) {
                            $(this).children("div").animate({top:100}, 200);
                            $(this).children("div").animate({top:85}, 300);
                            $(this).children("div").animate({top:90}, 200);
                        }
                    },
                    out:function () {
                        if (!$(this).hasClass("activeMenuItem")) {
                            $(this).children("div").animate({top:0}, 100);
                        }
                    },
                    timeout:500
                }
                $(this).hoverIntent(config);
                $(this).on("click", function () {
                            $('div.menu a').each(function () {
                                        var str = location.href;
                                        var parts = location.href.split('/');
                                        var href = "/" + parts[parts.length - 2] + "/" + parts[parts.length - 1];
                                        if ($(this).attr("href") == href) {
                                            $(this).children("div").animate({top:90}, 200);
                                            $(this).addClass("activeMenuItem");
                                        } else {
                                            $(this).children("div").animate({top:0}, 100);
                                            $(this).removeClass("activeMenuItem");
                                        }
                                    }

                            )
                        }
                )
                ;

            });
        });
    </script>
</guiceae:head>

<body>

<div id="main-container">
    <guiceae:menu/>
    <div id="body" align="center">
        <div class="collage">
            <%--<img src="collage"/>--%>
            <div id="greetings">
            </div>
        </div>

        <div id="feed-place">
            <div class="gutter-outer"></div>
            <div id="news" class="column feed"></div>
            <div class="gutter"></div>
            <div id="charity" class="column feed"></div>
            <div class="gutter"></div>
            <div id="people-chat" class="column feed"></div>
            <div class="gutter-outer"></div>
        </div>
    </div>
    <guiceae:footer/>
</div>
</body>
</html>
