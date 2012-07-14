<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<head>
    <link rel="stylesheet" href="/css/style.css" type="text/css" media="screen"/>
    <link rel="stylesheet" href="/css/ui-lightness/jquery-ui-1.8.21.custom.css" type="text/css" media="screen"/>
    <script type='text/javascript' src='/js/json2.js'></script>
    <script type='text/javascript' src='/js/jquery/jquery-1.7.2.js'></script>
    <script type='text/javascript' src='/js/jquery/jquery.hoverIntent.js'></script>
    <script type='text/javascript' src='/js/jquery-ui-1.8.21.custom.min.js'></script>

    <%--menu handling--%>
    <script type="text/javascript">
        $(function () {

            $("div.menu div").each(function () {
                $(this).find("a").before($("#pic").html());
                $(this).children("div").animate({top:-25}, 100);
                var config = {
                    over:function () {
                        if (!$(this).hasClass("activeMenuItem")) {
                            $(this).children("div").animate({top:20}, 200);
                            $(this).children("div").animate({top:15}, 300);
                            $(this).children("div").animate({top:17}, 200);
                        }
                    },
                    out:function () {
                        if (!$(this).hasClass("activeMenuItem")) {
                            $(this).children("div").animate({top:-25}, 100);
                        }
                    },
                    timeout:500
                }
                $(this).hoverIntent(config);
                $(this).find("a").on("click", function () {
                            $('div.menu div').each(function () {
                                        var str = location.href;
                                        var s = location.href.split('/');
                                        var href = "/" + s[s.length - 2] + "/" + s[s.length - 1];
                                        if ($(this).find("a").attr("href") == href) {
                                            $(this).children("div").animate({top:90}, 200);
                                            $(this).addClass("activeMenuItem");
                                        } else {
                                            $(this).children("div").animate({top:0}, 100);
                                            $(this).removeClass("activeMenuItem");
                                        }
                                    }

                            )
                        }
                );

            });

            $(".admin-menu").hover(function () {
                        $(".admin-menu").animate({right:0}, 300);
                    },
                    function () {
                        $(".admin-menu").animate({right:-100}, 300);
                    });

        });
    </script>
    <jsp:doBody/>
</head>

