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
    <title>Редагування відео</title>

    <script type="text/javascript">
        $(function () {

            $("#submitNewVideo").on("click", function () {
                var data = {
                    id:$("#video-id").val(),
                    title:$("#video-title").val(),
                    youtubeUrl:$("#video-url").val(),
                    description:$("#video-desc").val()
                };

                $.ajax({
                    type:"POST",
                    url:"/app/album/video/merge",
                    data:JSON.stringify(data),
                    cache:false,
                    contentType:"application/json; charset=utf-8",
                    dataType:"json",
                    error:function () {
                        console.log("very bad thing happen");
                    }
                }).done(function () {
                            window.location.replace("/app/album/gallery/videos");
                        });
            });
        });
    </script>
</guiceae:head>
<body>

<div>
    <button id="submitNewVideo">Add video</button>

    <div>
        <input type="hidden" value="${it.id}" id="video-id"/>

        <label for="video-title">Назва відео</label>
        <input id="video-title" class="title" maxlength="200" value="${it.title}"/>

        <label for="video-desc">Опис відео</label>
        <input type="text" id="video-desc" value="${it.description}"/>

        <label for="video-url">Посилання на відео(url)</label>
        <input type="text" id="video-url" value="${it.youtubeUrl}"/>

    </div>
</div>
</body>
</html>