<%--
  User: boui
  Date: 6/27/12
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="guiceae" uri="http://guiceae.org" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <guiceae:head/>
    <guiceae:photo-scripts/>

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
                    url:"/app/photo/newPhotos",
                    data:JSON.stringify(data),
                    cache:false,
                    contentType:"application/json; charset=utf-8",
                    dataType:"json",
                    error:function () {
                        console.log("very bad thing happen");
                    }
                }).done(function () {
                            window.location.replace("/app/photo/albums");
                        });
            });
        });
    </script>
    <title>Album workshop</title>
</head>
<body>
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
    <button id="submitNewPhotos">Add photos</button>
</div>
</body>
</html>