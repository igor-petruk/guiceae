<%--
  User: boui
  Date: 7/12/12
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="guiceae" uri="http://guiceae.org" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<guiceae:head>
    <guiceae:photo-scripts></guiceae:photo-scripts>
    <script type="text/javascript" charset="utf-8">
        function sendShowRequest(albumId) {
            var albumInfo = $.ajax({
                type:'GET',
                url:'get/' + albumId
            });

            $.ajax({
                type:'GET',
                url:'/app/album/photos/' + albumId,
                success:function (photos) {
                    initializeGalleryView(photos);
                }
            });
        }

        function initializeGalleryView(photos) {
            if (photos && photos.length > 0) {
                $("#album-thumbs ul.thumbs").html("");
                for (var i in photos) {

                    var photoInfo = $("<li>" +
                            "<a class='thumb' href='' title=''>" +
                            "<img src='" + photos[i].servingUrl + "=s200'/></a>" +
                            "<div class='caption'><div class='image-title'>" + photos[i].title + "</div><div class='image-desc'>" + photos[i].description + "</div>" +
                            "</div>" +
                            "</li>");
                    $("#album-thumbs ul").append(photoInfo);
                    getGallery();
                }
            }
        }

        function getGallery() {
            var onMouseOutOpacity = 0.67;
            $('#album-thumbs ul.thumbs li').opacityrollover({
                mouseOutOpacity:onMouseOutOpacity,
                mouseOverOpacity:1.0,
                fadeSpeed:'fast',
                exemptionSelector:'.selected'
            });

            var gallery = $('#album-thumbs').galleriffic({
                delay:2000,
                numThumbs:2,
                preloadAhead:5,
                enableTopPager:true,
                enableBottomPager:true,
                maxPagesToShow:20,
                imageContainerSel:'#slideshow',
                controlsContainerSel:'#controls',
                captionContainerSel:'#caption',
                loadingContainerSel:'#loading',
                renderSSControls:false,
                renderNavControls:true,
                playLinkText:'Play Slideshow',
                pauseLinkText:'Pause Slideshow',
                prevLinkText:'&lsaquo; Previous Photo',
                nextLinkText:'Next Photo &rsaquo;',
                nextPageLinkText:'Next &rsaquo;',
                prevPageLinkText:'&lsaquo; Prev',
                enableHistory:false,
                autoStart:false,
                syncTransitions:true,
                defaultTransitionDuration:200,
                onSlideChange:function (prevIndex, nextIndex) {
                    // 'this' refers to the gallery, which is an extension of $('#thumbs')
                    this.find('ul.thumbs').children()
                            .eq(prevIndex).fadeTo('fast', onMouseOutOpacity).end()
                            .eq(nextIndex).fadeTo('fast', 1.0);
                },
                onPageTransitionOut:function (callback) {
                    this.fadeTo('fast', 0.0, callback);
                },
                onPageTransitionIn:function () {
                    this.fadeTo('fast', 1.0);
                }
            });
        }
    </script>
</guiceae:head>
<body>

<div id="main-container">
    <guiceae:menu/>
    <guiceae:admin-menu/>
    <div class="body" align="center">

        <div id="albums-list">
            <%--//show all about album here--%>
            <c:forEach items="${it['albums']}" var="album">
                <div class="album-place">
                    <div class="title">${album.title}</div>
                    <div class="album-main-thumb">
                        <a style="text-decoration: none;" onclick="sendShowRequest('${album.id}')">
                            <img src="/css/images/dock-menu/flag1.PNG" alt="first album"/></a>
                    </div>
                    <div class="description">${album.description}</div>
                </div>
            </c:forEach>
        </div>
        <div id="album-show">

            <div id="gallery" class="content">
                <div id="controls" class="controls"></div>
                <div class="slideshow-container">
                    <div id="loading" class="loader"></div>
                </div>
                <div id="caption" class="caption-container"></div>
            </div>
            <div id="album-thumbs" class="navigation">
                <ul class='thumbs noscript'></ul>
            </div>

            <div id="slideshow" class="slideshow"></div>
            <%--<div style="clear: both;"></div>--%>
        </div>
    </div>
    <guiceae:footer/>
</div>
</body>
</html>