<!DOCTYPE HTML PUBLIC "-//W3//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<%--
  User: boui
  Date: 7/12/12
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="guiceae" uri="http://guiceae.org" %>

<html>
<guiceae:head>
    <title>Галерея</title>
    <guiceae:photo-scripts/>
    <script type="text/javascript" charset="utf-8">
        var gal;
        $(function () {
            var id = $(".album-view:first").attr("albumId");
            sendShowRequest(id);
            Galleria.loadTheme('/js/galleria.classic.min.js');
        });

        function sendShowRequest(albumId) {

            $("#galleria").remove();
            $('.view-right-place').append($("<div id='galleria' style='z-index:1'></div>"));

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
                var photoInfo = [];
                for (var i in photos) {
                    photoInfo.push({
                                title:photos[i].title,
                                description:photos[i].description,
                                image:photos[i].servingUrl,
                                thumb:photos[i].servingUrl + '=s60'
                            }
                    );
                }
                initGalleria(photoInfo);
            }
        }

        function initGalleria(photoInfo) {
            Galleria.configure({
                thumbnails:true
            });
            Galleria.run("#galleria", {
                transition:'fade',
                imageCrop:false,
                idleMode:true,
                showInfo:true,
                dataSource:photoInfo,
                extend:function (options) {
                    this.bind('image', function (e) {
                        // lets make galleria open a lightbox when clicking the main image:
                        $(e.imageTarget).click(this.proxy(function () {
                            this.openLightbox();
                        }));
                    });
                }
            });
        }
    </script>
</guiceae:head>
<body>

<div id="head">
    <guiceae:quick-panel/>
</div>

<div id="personal-not-main">
    <div class="name">Персональний сайт Івана Куровського</div>
    <div class="background"><img src="/css/images/system/personal_not_main.png"/></div>
    <div class="sub-label">Галерея</div>
</div>


<guiceae:new-menu/>


<div id="content">
    <div id="content_cen">
        <div id="content_sup">

            <div class="left-place">
                <span>Оберіть альбом ↓</span>
                <c:forEach items="${it['albums']}" var="album">

                    <div class="album-view" albumId="${album.id}">
                        <div class="title">${album.title}</div>
                        <div class="album-main-thumb">
                            <a style="text-decoration: none;" onclick="sendShowRequest('${album.id}')">
                                <img src="/css/images/system/NOT_USED/albums.png" alt="first album"/></a>
                        </div>
                        <div class="description">${album.description}</div>
                        <guiceae:rolesOnly roles="cm">
                            <div class="crud-place">
                                <a href="/app/album/update/${album.id}">Редагувати фотоальбом</a>
                                <a href="/app/album/delete/${album.id}">Видалити фотоальбом</a>
                            </div>
                        </guiceae:rolesOnly>
                    </div>
                </c:forEach>
            </div>

            <div class="view-right-place">
                <guiceae:rolesOnly roles="cm">
                    <a href="/app/album/new">Додати альбом</a> |
                    <a href="/app/photo/admin">Додати фото</a>
                </guiceae:rolesOnly>
                <div id="galleria" style="z-index:1">
                </div>

            </div>

        </div>
    </div>
</div>

<guiceae:footer/>
</body>
</html>