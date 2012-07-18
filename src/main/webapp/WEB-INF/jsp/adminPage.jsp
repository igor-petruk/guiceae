<!DOCTYPE HTML PUBLIC "-//W3//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<%--
  User: boui
  Date: 7/17/12
--%>
<%@ page import="com.google.appengine.api.blobstore.BlobstoreService" %>
<%@ page import="com.google.appengine.api.blobstore.BlobstoreServiceFactory" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="guiceae" uri="http://guiceae.org" %>

<html>
<guiceae:head>
    <title>Admin page</title>
    <link rel="stylesheet" href="/css/admin-pages.css" type="text/css" media="screen"/>

    <%--update photo description--%>
    <script type="text/javascript">
        $(function () {
            $("#submitNewPhotos").on("click", function () {
                var data = [];
                $(".newDescription").each(function () {
                    data = $.extend({
                        id:$(this).attr("id"),
                        description:$(this).val(),
                        albumId:$("#album option:selected").val(),
                        title:$("#title").val()
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
                            window.location.replace("/app/album/all");
                        });
            });
        });
    </script>
</guiceae:head>
<body>

<div id="head">
    <guiceae:quick-panel/>
</div>

<guiceae:new-menu/>

<div id="content">
    <div id="content_cen">
        <div id="content_sup">
            <div class="newAlbumForm">
                <div class="name">ADD NEW ALBUM</div>

                <form action="/app/album/addNew" method="POST" style="display: inline;">

                    <span>Album title</span>
                    <input type="text" name="title" maxlength="200"/>
                    <span>Album description</span>
                    <input type="text" name="description" maxlength="200"/>
                    <button>Add new album</button>
                </form>
            </div>

            <div class="new-photo">
                <div class="name">ADD NEW PHOTO</div>
                <%BlobstoreService blobstorageService = BlobstoreServiceFactory.getBlobstoreService();%>
                <form action="<%= blobstorageService.createUploadUrl("/app/upload")%>" method="POST"
                      enctype="multipart/form-data">
                    <input type="file" name="photos"/>
                    <input type="submit" value="Upload"/>
                </form>
            </div>


            <%--<div class="introduce-photo-div">--%>

            <%--<div class="name">ADD NEW PHOTO</div>--%>
            <%--<c:forEach var="photo" items="${newPhotos}">--%>
            <%--<div class="intr-photo-row-box">--%>
            <%--<img src="${photo.servingUrl}=s200" class="thumbnailPhoto" alt=""/>--%>

            <%--<span>Назва фотографії</span>--%>
            <%--<input id="title" maxlength="200"/>--%>

            <%--<span>Опис фотографії</span>--%>
            <%--<textarea cols="300" rows="5" type="text" class="newDescription"--%>
            <%--id="${photo.id}"></textarea>--%>

            <%--<select id="album">--%>
            <%--<c:forEach var="album" items="${albums}">--%>
            <%--<option value="${album.id}">${album.title}</option>--%>
            <%--</c:forEach>--%>
            <%--</select>--%>
            <%--</div>--%>
            <%--</c:forEach>--%>
            <%--<button id="submitNewPhotos">Add photo</button>--%>
            <%--</div>--%>
        </div>
    </div>
</div>
<guiceae:footer/>
<%--<guiceae:feed shortView="false" pagesCount="true" currentFirst="true" feed="" feedName="news"/>--%>

</body>
</html>