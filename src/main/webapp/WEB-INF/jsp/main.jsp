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
            <p style="font-weight:bold; float:left; margin-left: 40%;margin-top: 10px;">Шановні друзі!</p>

            <p>Моїй команді і меня особисто, як народному депутатові України, видається вкрай необхідним тримати
                постійний зворотний зв'язок із виборцями, для оцінки наших намірів, думок і діяльності.</p>

            <p>Користуючись цим ресурсом Ви зможете дізнатися про мої життєві пріоритети,
                законотворчу, громадську та благодійну діяльність, участь у житті виборчого округу.
                Я завжди готовий до обміну думками і конструктивної дискусії з усіма,
                хто цікавиться моєю роботою.</p>

            <p>Проблеми, які обговорюватимуться тут, стануть предметом майбутніх депутатських запитів,
                законопроектів, відправною точкою їх вивчення і розв’язання.
            </p>
            </p>
            <p>

            <p style="float:left;font-weight:bold;margin-left: 79%;">З повагою,</p>

            <p style="float:left;font-weight:bold; margin-left: 42%;">Народний депутат України Іван
                Куровський</p>
            </p>
        </div>
    </div>
</div>

<guiceae:new-menu/>


<div id="content">
    <div id="content_cen">
        <div id="content_sup">

            <div id="infoPan">
                <div class="gutter-outer" style="border-left: 20px solid #fefefe"></div>

                <div class="column">
                    <span class="head">
                        <a href="/app/feed/charity">Благодійність</a>
                    </span>
                    <%--<span>--%>
                    <%--<a class="rss" href="/app/feed/charity/rss"><img src="/css/images/system/rss.png"--%>
                    <%--alt="Підписатися на оновлення"></a>--%>
                    <%--</span>--%>
                    <guiceae:smallFeed feedName="charity" feed="${it.charityFeed}"/>
                </div>

                <div class="gutter"></div>

                <div class="column">
                    <span class="head">
                       <a href="/app/feedback/submit/question">Громадська приймальня</a>
                    </span>
                    <%--<span>--%>
                    <%--<a class="rss" href="/app/feed/news/rss">--%>
                    <%--<img src="/css/images/system/rss.png" alt="Підписатися на розсилку"/>--%>
                    <%--</a>--%>
                    <%--</span>--%>
                </div>

                <div class="gutter"></div>

                <div class="column">
                    <span class="head">
                        <a href="/app/feed/news">Новини</a>
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
