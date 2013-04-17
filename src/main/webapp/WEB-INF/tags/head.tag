<%@ tag pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="guiceae" uri="http://guiceae.org" %>
<head>
    <link rel="stylesheet" href="/css/ui-lightness/jquery-ui-1.8.21.custom.css" type="text/css" media="screen"/>
    <script type='text/javascript' src='/js/json2.js'></script>
    <script type='text/javascript' src='/js/jquery/jquery-1.7.2.js'></script>
    <script type='text/javascript' src='/js/jquery/jquery.hoverIntent.js'></script>
    <script type='text/javascript' src='/js/jquery-ui-1.8.21.custom.min.js'></script>
    <script type='text/javascript' src='/js/jquery.validate.min.js'></script>
    <script type='text/javascript' src='/js/entityPoller.js'></script>
    <link href="/css/main.css" rel="stylesheet" type="text/css" media="all"/>
    <link href="/css/style.css" rel="stylesheet" type="text/css" media="all"/>
    <script type="text/javascript" src="http://vk.com/js/api/share.js?11" charset="windows-1251"></script>
    <script src="/js/jquery/expander.js"></script>

    <script type="text/javascript">
        function twitter() {
            !function (d, s, id) {
                var js, fjs = d.getElementsByTagName(s)[0];
                if (!d.getElementById(id)) {
                    js = d.createElement(s);
                    js.id = id;
                    js.src = "https://platform.twitter.com/widgets.js";
                    fjs.parentNode.insertBefore(js, fjs);
                }
            }(document, "script", "twitter-wjs");
        }

        $(function () {
            $("div.menu div").each(function () {
                $(this).find("a").before($("#pic").html());
                $(this).children("div").animate({top: -25}, 100);
                var config = {
                    over: function () {
                        if (!$(this).hasClass("activeMenuItem")) {
                            $(this).children("div").animate({top: 20}, 200);
                            $(this).children("div").animate({top: 15}, 300);
                            $(this).children("div").animate({top: 17}, 200);
                        }
                    },
                    out: function () {
                        if (!$(this).hasClass("activeMenuItem")) {
                            $(this).children("div").animate({top: -25}, 100);
                        }
                    },
                    timeout: 500
                }
                $(this).hoverIntent(config);
                $(this).find("a").on("click", function () {
                            $('div.menu div').each(function () {
                                        var str = location.href;
                                        var s = location.href.split('/');
                                        var href = "/" + s[s.length - 2] + "/" + s[s.length - 1];
                                        if ($(this).find("a").attr("href") == href) {
                                            $(this).children("div").animate({top: 90}, 200);
                                            $(this).addClass("activeMenuItem");
                                        } else {
                                            $(this).children("div").animate({top: 0}, 100);
                                            $(this).removeClass("activeMenuItem");
                                        }
                                    }

                            )
                        }
                );

            });

            $(".admin-menu").hover(function () {
                        $(".admin-menu").animate({right: 0}, 300);
                    },
                    function () {
                        $(".admin-menu").animate({right: -100}, 300);
                    });

        });
    </script>
    <jsp:doBody/>
    <script type="text/javascript">

        var _gaq = _gaq || [];
        _gaq.push(['_setAccount', 'UA-34062991-1']);
        _gaq.push(['_trackPageview']);

        (function () {
            var ga = document.createElement('script');
            ga.type = 'text/javascript';
            ga.async = true;
            ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
            var s = document.getElementsByTagName('script')[0];
            s.parentNode.insertBefore(ga, s);
        })();
    </script>

    <script type="text/javascript">
        function effectOnArrow() {
            $("#funny-arrow").effect("bounce", {direction: "right", times: 1}, 300);
        }
    </script>
</head>

