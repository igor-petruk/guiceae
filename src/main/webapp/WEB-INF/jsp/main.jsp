<!DOCTYPE HTML PUBLIC "-//W3//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="guiceae" uri="http://guiceae.org" %>

<html>
<guiceae:head>
    <guiceae:photo-scripts/>
    <script type="text/javascript" src="/js/feed.js"></script>
    <script type="text/javascript" charset="utf-8">
        $(function () {
            // Load the classic theme
            Galleria.loadTheme('/js/galleria.classic.min.js');
            Galleria.configure({
                thumbnails:false
            });
            // Initialize Galleria
            Galleria.run('#galleria-main', {
                transition:'fade',
                autoplay:3000,
                carousel:false,
                thumbFit:false,
                thumbMargin:0,
                imageCrop:true,
                touch:false,
                showCounter:false,
                showImagenav:false,
                showInfo:false
            });
            $("#menu div#main").addClass("active");
        });


    </script>
</guiceae:head>

<body>
<div id="head">

    <guiceae:quick-panel/>

    <div class="view">
        <div id="portrait" style="z-index:5">
            <img src="/css/images/main/kurovskiy/portrait.png"/>
        </div>

        <div id="galleria-main" style="z-index:1">
            <a href="/css/images/main/kurovskiy/banner1.png">
                <img data-title=""
                     data-description=""
                     src="/css/images/main/kurovskiy/banner1.png">
            </a>
            <a href="/css/images/main/kurovskiy/field.png">
                <img data-title=""
                     data-description=""
                     src="/css/images/main/kurovskiy/field.png">
            </a>
        </div>

        <div id="personal">
            <img src="/css/images/system/personal.png"/>

            <div class="name">Іван Куровський</div>
            <div class="sub-label">Персональний сайт</div>
            <div class="separator"></div>
        </div>


        <div id="welcom_pan">
            <h2><span>Вітаю на моїй сторінці!</span></h2>

            <p>Тут Ви зможете прочитати
                про мою діяльність, програму,
                зрозуміти які основні напрямки моєї роботи,
                задати питання, що вас хвилюють і залишити відгуки
                та побажання!
            </p>

            <p style="float:right;">З повагою, Іван Куровський</p><br/>
        </div>
    </div>
</div>

<guiceae:new-menu/>


<div id="content">
    <div id="content_cen">
        <div id="content_sup">

            <div id="infoPan">
                <div class="gutter-outer"></div>

                <div class="column">
                    <span class="head">
                        <a href="/app/feed/charity">Благодійність</a>
                    </span>
                    <span>
                        <a class="rss" href="/app/feed/charity/rss"><img src="/css/images/system/rss.png"
                                                                         alt="Підписатися на оновлення"></a>
                    </span>
                    <guiceae:smallFeed feedName="charity" feed="${it.charityFeed}"/>
                </div>

                <div class="gutter"></div>

                <div class="column">
                    <span class="head">
                       <a href="/app/feedback/view/question">Громадська приймальня</a>
                    </span>
                    <span>
                        <a class="rss" href="/app/feed/news/rss">
                            <img src="/css/images/system/rss.png" alt="Підписатися на розсилку"/>
                        </a>
                    </span>
                </div>

                <div class="gutter"></div>

                <div class="column">
                    <span class="head">
                        <a href="/app/feed/news">Новини</a>
                    </span>
                    <span>
                        <a class="rss" href="/app/feed/news/rss"><img src="/css/images/system/rss.png"
                                                                      alt="Підписатися на оновлення"></a>
                    </span>
                    <guiceae:smallFeed feedName="news" feed="${it.newsFeed}"/>
                </div>
                <div class="gutter-outer"></div>
            </div>
        </div>
    </div>

    <guiceae:footer/>
</body>
</html>
