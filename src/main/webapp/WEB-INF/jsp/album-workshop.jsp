<%--
  User: boui
  Date: 6/28/12
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="guiceae" uri="http://guiceae.org" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <guiceae:head>
        <guiceae:photo-scripts/>

    <script type="text/javascript" charset="utf-8">
        $(document).ready(function () {

//            set all photos into positions
            $("div.photo").each(function () {
                var albumId = $(this).attr("id");
                $("#album-gallery" + albumId + " ul").append('<li>' + $(this).html() + '</li>');
            });

//            gallerific magic
            var onMouseOutOpacity = 0.67;
            $('#thumbs ul.thumbs li, div.navigation a.pageLink').opacityrollover({
                mouseOutOpacity:onMouseOutOpacity,
                mouseOverOpacity:1.0,
                fadeSpeed:'fast',
                exemptionSelector:'.selected'
            });

            $("div.album-gallery").each(function () {

                var gallery = $(this).galleriffic({
                    delay:2500,
                    numThumbs:3,
                    preloadAhead:5,
                    enableTopPager:true,
                    enableBottomPager:true,
                    maxPagesToShow:7,
                    imageContainerSel:'#slideshow', //+ $(this).attr("id"),
                    controlsContainerSel:'#controls', // + $(this).attr("id"),
                    captionContainerSel:'#caption', // + $(this).attr("id"),
                    loadingContainerSel:'#loading', // + $(this).attr("id"),
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
                    defaultTransitionDuration:900,
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
            });
        });

    </script>

    <title>
        Album workshop page
    </title>
    </guiceae:head>
<body>

<guiceae:admin-menu></guiceae:admin-menu>
<guiceae:menu></guiceae:menu>

<table>
    <tr>
        <td>
            <div id="slideshow" class="slideshow"></div>
        </td>
    </tr>

    <c:forEach var="album" items="${it['albums']}">
        <tr>
            <td>
                <div class="navigation-container">
                    <a class="pageLink prev" style="visibility: hidden;" href="#" title="Previous Page"></a>

                    <div id="${album.id}" class="album navigation">
                        <div id="album-gallery${album.id}" class="album-gallery">
                            <ul class="thumbs noscript"></ul>
                        </div>
                    </div>
                    <a class="pageLink next" style="visibility: hidden;" href="#" title="Next Page"></a>
                </div>
            </td>
            <td>
                <div class="album-caption">
                    <div class="album-title">${album.title}</div>
                    <div class="album-desc">${album.description}</div>
                    <div class="admin-controls" style="font-size: large;">
                        <a href="/app/album/update?id=${album.id}">Update album</a>
                        <a href="/app/album/delete?id=${album.id}">Delete album</a>
                    </div>
                </div>
            </td>
        </tr>
    </c:forEach>

</table>

<div style="display:none;">
    <c:forEach var="photo" items="${it['photos']}">
        <div id="${photo.albumId}" class="photo">
            <a href="${photo.servingUrl}" class="thumb" title="${photo.title}"><img
                    src="${photo.servingUrl}=s200" alt="${photo.description}"/></a>

            <div class="caption">
                <div class="image-title">${photo.title}</div>
                <div class="image-desc">${photo.description}</div>
                <div class="admin-controls">
                    <a href="/app/photo/update?id=${photo.id}">Update photo</a>
                    <a href="/app/photo/delete?id=${photo.id}">Delete photo</a>
                </div>
            </div>
        </div>
    </c:forEach>
</div>


</body>
</html>