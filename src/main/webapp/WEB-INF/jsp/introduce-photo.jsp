<%--
  User: boui
  Date: 6/27/12
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="guiceae" uri="http://guiceae.org" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<guiceae:head>
    <title>Album workshop</title>

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

<button id="submitNewPhotos">Add photo</button>

<div class="content">
    <c:forEach var="photo" items="${newPhotos}">
        <div class="intr-photo-row-box">
            <img src="${photo.servingUrl}=s200" class="thumbnailPhoto" alt=""/>
            <input id="title" maxlength="200"/>
            <textarea cols="100" rows="5" type="text" class="newDescription" id="${photo.id}"></textarea>
            <select id="album">
                <c:forEach var="album" items="${albums}">
                    <option value="${album.id}">${album.title}</option>
                </c:forEach>
            </select>
        </div>
    </c:forEach>
</div>
</body>
</html>