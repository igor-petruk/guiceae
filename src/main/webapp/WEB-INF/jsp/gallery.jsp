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
        $(function () {
            $("#galleria").html("");
            var id = $("#albums-list div:first").attr("albumId");
            id = "#" + id;
            sendShowRequest(id);
            $("#menu div#gallery").addClass("active");
        });

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

                $("#galleria").html("");
                for (var i in photos) {

                    var photoInfo = $(
                            "<a href='" + photos[i].servingUrl + "'>" +
                                    "<img data-title='" + photos[i].title + "'" +
                                    "data-description='" + photos[i].description + "'" +
                                    "src='" + photos[i].servingUrl + "=s60'/>" +
                                    "</a>");
                    $("#galleria").append(photoInfo);
                }

                initGalleria("#galleria");
            }
        }

        function initGalleria(id) {
            // Load the classic theme
            Galleria.loadTheme('/js/galleria.classic.min.js');
            Galleria.configure({
                thumbnails:true
            });
            // Initialize Galleria
            Galleria.run(id, {
                transition:'fade',
                imageCrop:false,
                idleMode:true,
                showInfo:true
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
                    </div>
                </c:forEach>
            </div>

            <div class="view-right-place">
                <guiceae:rolesOnly roles="cm">
                    <a href="/app/photo/admin">Додати альбом чи фото</a>
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