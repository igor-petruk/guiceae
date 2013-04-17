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
                thumbnails: false
            });
            // Initialize Galleria
            Galleria.run('#galleria-main', {
                transition: 'fade',
                autoplay: 3000,
                carousel: false,
                thumbFit: false,
                thumbMargin: 0,
                imageCrop: true,
                touch: false,
                showCounter: false,
                showImagenav: false,
                showInfo: false
            });
            $("#menu div#main").addClass("active");
        });


    </script>
</guiceae:head>

<guiceae:body>
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
                <%--<img src="/css/images/system/personal.png"/>--%>
            <div class="name">Персональний сайт Івана Куровського</div>
        </div>


        <div id="welcom_pan">
            <guiceae:smallFeed feed="${it.mainFeed}" feedName="mainfeed"/>
                <%--<p style="font-weight:bold; float:left; margin-left: 40%;margin-top: 10px;">Шановні друзі!</p>--%>

                <%--<p>Мені як народному депутатові України онлайн-спілкування видається--%>
                <%--важливою ланкою вивчення проблем, які цікавлять людей.</p>--%>

                <%--<p>Користуючись цим ресурсом, Ви зможете дізнатися про мою--%>
                <%--депутатську, благодійну діяльність, участь у житті виборчого округу. Також ви--%>
                <%--маєте можливість звернутися до моєї громадської приймальні, щоб отримати--%>
                <%--відповіді на питання, які вас цікавлять.</p>--%>

                <%--<p>Я завжди готовий до обміну думками і конструктивної дискусії. Буду--%>
                <%--вдячний за ваші запитання і пропозиції.</p>--%>

                <%--<div style="float: right;  width: 60%; min-width: 360px;">--%>
                <%--<p style="float:right;font-weight:bold;">З повагою,</p>--%>

                <%--<p style="float:right;font-weight:bold;">Народний депутат України Іван Куровський</p>--%>
                <%--</div>--%>
        </div>
    </div>
</div>

<guiceae:new-menu/>


<div id="content">
    <div id="content_cen">
        <div id="content_sup">

            <div id="infoPan">

                <div class="column">
                    <span class="head">
                        <a href="/app/feed/charity">
                            <span class="pic"><img class="first" src="/css/images/system/charity.png"
                                                   alt="Більше про благодійну діяльність"/></span>
                            <span>Благодійність</span>
                        </a>
                    </span>
                        <%--<span class="separator"></span>--%>
                        <%--<span>--%>
                        <%--<a class="rss" href="/app/feed/charity/rss"><img src="/css/images/system/rss.png"--%>
                        <%--alt="Підписатися на оновлення"></a>--%>
                        <%--</span>--%>
                    <guiceae:smallFeed feedName="charity" feed="${it.charityFeed}"/>
                </div>

                <div class="column-center column" style="margin-left: 2%;">
                    <span class="head">
                        <a href="/app/feed/news">
                            <span class="pic"><img src="/css/images/system/news.png" alt="Більше новин із ЗМІ"/></span>
                            <span>Новини, ЗМІ</span>
                        </a>
                    </span>
                        <%--<span class="separator"></span>--%>
                    <guiceae:smallFeed feedName="news" feed="${it.newsFeed}"/>
                </div>
                <div class="column" style="margin-left: 2%;background-color: #ffffff">
                    <span class="head">
                       <a href="/app/feedback/submit/question">
                           <span class="pic"><img src="/css/images/system/chat.png" alt="Задати питання"/></span>
                           <span>Громадська приймальня</span>
                       </a>
                    </span>
                    <c:if test="${not empty it.visit}">
                        <c:forEach items="${it.visit}" var="visit">
                            <guiceae:shortArticle article="${visit}" simpleDelete="true" social="true"/>
                        </c:forEach>
                    </c:if>
                </div>
            </div>
        </div>
    </div>

        <guiceae:footer/>
    </guiceae:body>
</html>
