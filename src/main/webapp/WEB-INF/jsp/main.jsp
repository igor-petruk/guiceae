<!DOCTYPE HTML PUBLIC "-//W3//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="guiceae" uri="http://guiceae.org" %>

<html>
<guiceae:head>
    <script type="text/javascript" src="/js/feed.js"></script>
</guiceae:head>

<body>
<div id="head">

    <p class="search">
        <label>ПОШУК</label>
        <input name="search" type="text" class="txt"/>
        <input name="search-btn" type="submit" class="btn" value="ЗНАЙТИ"/>

    <div class="login">
        <ul>
            <li>Написати<a href="#"><img src="/css/images/system/letter.png" title="Написати листа" height="64"
                                         width="64"/></a>
            </li>
            <li>Задати питання<a href="#"><img src="/css/images/system/question.png" title="Задати питання" height="64"
                                               width="64"/></a></li>
        </ul>
    </div>
    </p>

    <div class="view">
        <div id="portrait" style="z-index:5">
            <img src="/css/images/main/kurovskiy/portrait.png"/>
        </div>

        <div id="galleria-main" style="z-index:1">
            <a href="/css/images/main/kurovskiy/banner1.png">
                <img data-title="Locomotives Roundhouse"
                     data-description="Steam locomotives of the Chicago &amp; North Western Railway."
                     src="/css/images/main/kurovskiy/banner1.png">
            </a>
            <a href="/css/images/main/kurovskiy/flag.jpg">
                <img data-title="Icebergs in the High Arctic"
                     data-description="”The debris loading isn't particularly extensive, but the color is usual.”"
                     src="/css/images/main/kurovskiy/flag.jpg">
            </a>
        </div>

        <div id="personal">
            <div class="name">Іван Куровський</div>
            <div class="sub-label">Персональний сайт</div>
        </div>


        <div id="welcom_pan">
            <h2><span>Вітаю,</span> {username}!</h2>

            <p>Тут Ви зможете прочитати
                про мою діяльність, програму,
                зрозуміти які основні напрямки моєї роботи,
                задати питання, що вас хвилюють і залишити відгуки
                та побажання!
            </p>

            <p>
                Maecenas ut lacus magna, ut consectetur quam. Etiam pharetra tincidunt massa,
                vitae pulvinar eros commodo ut. Sed in orci neque. Mauris eros est, auctor vitae.
            </p>

            <p style="float:right;">З повагою, Іван Куровський</p><br/>
        </div>
    </div>
</div>

<div id="menu">
    <ul>
        <li><a class="active" href="index.html">Головна</a></li>
        <li><a href="#">Автобіографія</a></li>
        <li><a href="#">Громадська приймальня</a></li>
        <li><a href="#">Галерея</a></li>
    </ul>
</div>


<div id="content">
    <div id="content_cen">
        <div id="content_sup">

            <ul id="infoPan">
                <li id="charity">

                    <h3><span>Благодійність</span> <img src="/css/images/system/rss.png" alt="Підписатися на розсилку"/>
                    </h3>

                    <div class="article">
                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>

                        <p class="descrip">Maecenas ut lacus magna, ut consectetur quam. Etiam pharetra tincidunt massa,
                            vitae pulvinar eros commodo ut. Sed in orci neque. Mauris eros est, auctor vitae.</p>
                        <a href="#">Детальніше</a>
                    </div>
                    <div class="article">
                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>

                        <p class="descrip">Maecenas ut lacus magna, ut consectetur quam. Etiam pharetra tincidunt massa,
                            vitae pulvinar eros commodo ut. Sed in orci neque. Mauris eros est, auctor vitae.</p>
                        <a href="#">Детальніше</a>
                    </div>
                    <div class="article">
                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>

                        <p class="descrip">Maecenas ut lacus magna, ut consectetur quam. Etiam pharetra tincidunt massa,
                            vitae pulvinar eros commodo ut. Sed in orci neque. Mauris eros est, auctor vitae.</p>
                        <a href="#">Детальніше</a>

                    </div>
                </li>

                <li id="law">
                    <h3><span>Законодавчі</span> ініціативи <img src="/css/images/system/rss.png"
                                                                 alt="Підписатися на розсилку"/></h3>

                    <div class="article">
                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>

                        <p class="descrip">Maecenas ut lacus magna, ut consectetur quam. Etiam pharetra tincidunt massa,
                            vitae pulvinar eros commodo ut. Sed in orci neque. Mauris eros est, auctor vitae.</p>
                        <a href="#">Детальніше</a>
                    </div>
                    <div class="article">
                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>

                        <p class="descrip">Maecenas ut lacus magna, ut consectetur quam. Etiam pharetra tincidunt massa,
                            vitae pulvinar eros commodo ut. Sed in orci neque. Mauris eros est, auctor vitae.</p>
                        <a href="#">Детальніше</a>
                    </div>
                    <div class="article">
                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>

                        <p class="descrip">Maecenas ut lacus magna, ut consectetur quam. Etiam pharetra tincidunt massa,
                            vitae pulvinar eros commodo ut. Sed in orci neque. Mauris eros est, auctor vitae.</p>
                        <a href="#">Детальніше</a>
                    </div>
                </li>
                <li id="news">
                    <h3><span>Новини,</span>Події <img src="/css/images/system/rss.png" alt="Підписатися на розсилку"/>
                    </h3>

                    <div class="article">
                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>

                        <p class="descrip">Maecenas ut lacus magna, ut consectetur quam. Etiam pharetra tincidunt massa,
                            vitae pulvinar eros commodo ut. Sed in orci neque. Mauris eros est, auctor vitae.</p>
                        <a href="#">Детальніше</a>
                    </div>
                    <div class="article">
                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>

                        <p class="descrip">Maecenas ut lacus magna, ut consectetur quam. Etiam pharetra tincidunt massa,
                            vitae pulvinar eros commodo ut. Sed in orci neque. Mauris eros est, auctor vitae.</p>
                        <a href="#">Детальніше</a>
                    </div>
                    <div class="article">
                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>

                        <p class="descrip">Maecenas ut lacus magna, ut consectetur quam. Etiam pharetra tincidunt massa,
                            vitae pulvinar eros commodo ut. Sed in orci neque. Mauris eros est, auctor vitae.</p>
                        <a href="#">Детальніше</a>
                    </div>
                </li>
            </ul>

            <!--<div id="ct_pan">-->
            <!--<ul>-->
            <!--<li>-->
            <!--<a href="#">-->
            <!--<div class="album-place">-->
            <!--<div class="title">ALbum#0</div>-->
            <!--<div class="album-main-thumb">-->
            <!--<a style="text-decoration: none;">-->
            <!--<img src="images/system/biography.png" alt="album # 0"/></a>-->
            <!--</div>-->
            <!--<div class="description">asjdlak sjd lk ajsldk</div>-->
            <!--</div>-->
            <!--</a>-->
            <!--</li>-->
            <!--<li><a href="#">-->
            <!--<div class="album-place">-->
            <!--<div class="title">ALbum#1</div>-->
            <!--<div class="album-main-thumb">-->
            <!--<a style="text-decoration: none;">-->
            <!--<img src="images/system/biography.png" alt="album # 0"/></a>-->
            <!--</div>-->
            <!--<div class="description">asjdak sjhdk jahsd</div>-->
            <!--</div>-->
            <!--</a></li>-->
            <!--</ul>-->
            <!--</div>-->

            <!--<div id="quotPan">-->
            <!--<h3><span>get a free </span>quote</h3>-->
            <!--<input name="name" type="text" value="your name" class="txt"/>-->
            <!--<input name="id" type="text" value="email id" class="txt"/>-->
            <!--<input name="submit" type="submit" class="btn" value="submit"/>-->
            <!--</div>-->
            <!--<div id="blog">-->
            <!--<h3><span>from the</span> blog</h3>-->
            <!--<ul>-->
            <!--<li>-->
            <!--<a href="#">Lorem ipsum dolor sit amet, consectetur adipiscing elit.</a>-->

            <!--<p>Maecenas ut lacus magna, ut consectetur quam. Etiam pharetra tincidunt massa, vitae pulvinar-->
            <!--eros commodo ut. Sed in orci neque. Mauris eros est, auctor vitae.</p>-->
            <!--</li>-->
            <!--<li>-->
            <!--<a href="#">Lorem ipsum dolor sit amet, consectetur adipiscing elit.</a>-->

            <!--<p>Maecenas ut lacus magna, ut consectetur quam. Etiam pharetra tincidunt massa, vitae pulvinar-->
            <!--eros commodo ut. Sed in orci neque. Mauris eros est, auctor vitae.</p>-->
            <!--</li>-->
            <!--</ul>-->
            <!--</div>-->
            <!--<div id="latest">-->
            <!--<h3><span>latest </span>latest </h3>-->
            <!--<ul>-->
            <!--<li>-->
            <!--<a href="#">consectetur adipiscing elit.</a>-->

            <!--<p>Maecenas ut lacus magna, ut consectetur quam. Etiam pharetra tincidunt.</p>-->
            <!--</li>-->
            <!--<li>-->
            <!--<a href="#">consectetur adipiscing elit.</a>-->

            <!--<p>Maecenas ut lacus magna, ut consectetur quam. Etiam pharetra tincidunt.</p>-->
            <!--</li>-->
            <!--</ul>-->
            <!--</div>-->
        </div>
    </div>
</div>
<div id="foot">
    <div id="foot_cen">
        <p>© 2012, Igor Petruk and Roksana Seletska</p>
    </div>
</div>
</body>
</html>
