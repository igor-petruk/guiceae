<!DOCTYPE HTML PUBLIC "-//W3//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<%--
  User: boui
  Date: 6/27/12
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="guiceae" uri="http://guiceae.org" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<guiceae:head>
    <title>Редагування фотографії</title>

    <script type="text/javascript">
        $(function () {
            var oldAlbumId = $("#oldALbum").val();
            if (oldAlbumId && oldAlbumId.length > 0) {
                $("#album" + oldAlbumId).attr("selected", "selected");
            }

            $("#submitNewPhotos").on("click", function () {
                var data = [];
                $(".newDescription").each(function () {
                    data = $.extend({
                        id:$(this).attr("id"),
                        description:$(this).val(),
                        albumId:$("#album option:selected").val(),
                        title:$(".title").val()
                    }, data);
                });
                console.log(data);
                $.ajax({
                    type:"POST",
                    url:"/app/photo/update",
                    data:JSON.stringify(data),
                    cache:false,
                    contentType:"application/json; charset=utf-8",
                    dataType:"json",
                    error:function () {
                        console.log("very bad thing happen");
                    }
                }).done(function () {
                            window.location.replace("/app/album/gallery/photo");
                        });
            });
        });
    </script>
</guiceae:head>
<body>

<div>
    <button id="submitNewPhotos">Add photo</button>

    <div>
        <c:forEach var="photo" items="${photos}">
            <div>
                <img src="${photo.servingUrl}=s200"/>

                <label for="title">Назва фотографії</label>
                <input id="title" class="title" maxlength="200" value="${photo.title}"/>

                <label for="${photo.id}">Опис фотографії</label>
                <textarea cols="100" rows="5" type="text" class="newDescription" id="${photo.id}"></textarea>

                <label for="album">Оберіть альбом</label>
                <select id="album">
                    <c:forEach var="album" items="${albums}">
                        <option value="${album.id}" id="album${album.id}">${album.title}</option>
                    </c:forEach>
                    <c:if test="${not empty photo.albumId}">
                        <input type="hidden" value="${photo.albumId}" id="oldAlbum"/>
                    </c:if>
                </select>
            </div>
        </c:forEach>
    </div>
</div>
</body>
</html>