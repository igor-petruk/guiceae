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
            var whatToView = $("#whatToView").val();
            if (whatToView == 'true') {
                showVideoAlbum();
            } else {
                var id = $(".album-view:first").attr("albumId");
                sendShowRequest(id);
            }
            Galleria.loadTheme('/js/galleria.classic.min.js');
        });


        function showVideoAlbum() {
            $("#galleria").remove();
            $("#galleria-place").prepend($("<div id='galleria' style='z-index:1'></div>"));
            $("#galleria-admin-info").html("");
            $("#dynamic-a").html("");

            $.ajax({
                type:'GET',
                url:'/app/album/video/all',
                success:function (videos) {
                    if (videos && videos.length > 0) {
                        var videoInfo = [];
                        for (var i in videos) {
                            videoInfo.push({
                                        id:videos[i].id,
                                        showWhen:"videos",
                                        title:videos[i].title,
                                        description:videos[i].description,
                                        video:videos[i].youtubeUrl
                                    }
                            );
                        }
                        initGalleria(videoInfo);
                    }
                }
            });

        }
        function sendShowRequest(albumId) {
            $("#galleria").remove();
            $("#galleria-place").prepend($("<div id='galleria' style='z-index:1'></div>"));
            $("#galleria-admin-info").html("");
            $("#dynamic-a").html("");

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
                                id:photos[i].id,
                                showWhen:"photos",
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

        function initGalleria(info) {
            Galleria.configure({
                thumbnails:true
            });

            for (var el in info) {
                createDynamicLinks(info[el].showWhen == 'photos', "#galleria-admin-info", info[el].title.substring(0, 10) + "...| ", info[el].id);
            }

            Galleria.run("#galleria", {
                transition:'fade',
                imageCrop:false,
                idleMode:true,
                showInfo:true,
                dataSource:info,
                extend:function (options) {
                    this.bind('image', function (e) {
                        $("#dynamic-a").html("");
                        createDynamicLinks(info[e.index].showWhen == 'photos', "#dynamic-a", '|', info[e.index].id);
                    });
                }
            });
        }

        function createDynamicLinks(isPhotos, selector, name, id) {
            if (isPhotos) {
                $(selector).append($("<a id='dynamic-update-photo' href='/app/photo/updatePage/" + id + "'>Редагувати фото " + name + "</a>"));
                $(selector).append($("<a id='dynamic-delete-photo' href='/app/photo/delete/" + id + "'>Видалити фото " + name + "<br/>"));
            } else {
                $(selector).append($("<a id='dynamic-update-video' href='/app/album/video/mergePage/" + id + "'>Редагувати відео " + name + "</a>"));
                $(selector).append($("<a id='dynamic-delete-video' href='/app/album/video/delete/" + id + "'>Видалити відео " + name + "</a><br/>"));
            }
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

<input type="hidden" value="${it.whatToView}" id="whatToView"/>

<div id="content">
    <div id="content_cen">
        <div id="content_sup">

            <div class="left-place">
                <span id="functional-propose">Оберіть альбом ↓</span>
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


                <div class="video-album-view" albumId="${album.id}">
                    <div class="title">Відеоальбом</div>
                    <div class="album-main-thumb">
                        <a style="text-decoration: none;" onclick="showVideoAlbum()">
                            <img src="/css/images/system/NOT_USED/albums.png" alt="first album"/></a>
                    </div>
                </div>
            </div>

            <div class="view-right-place albums">
                <guiceae:rolesOnly roles="cm">
                    <span class="menu-addon">
                    <a href="/app/album/new">Додати альбом</a> |
                    <a href="/app/photo/admin">Додати фото</a> |
                    <a href="/app/album/video/new">Додати відео</a>|
                    <span id="dynamic-a"></span>
                        </span>
                </guiceae:rolesOnly>
                <div id="galleria-place"></div>
                <div id="galleria" style="z-index:1">
                </div>
                <guiceae:rolesOnly roles="cm">
                    <span class="menu-addon">
                        <div id="galleria-admin-info" style="font-weight:bold;"></div>
                    </span>
                </guiceae:rolesOnly>
            </div>

        </div>
    </div>
    <guiceae:footer/>
</div>

</body>
</html>