<!DOCTYPE HTML PUBLIC "-//W3//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="guiceae" uri="http://guiceae.org" %>
<html>
<guiceae:head>
    <guiceae:photo-scripts/>
    <link rel="stylesheet" href="/css/fileuploader.css"/>
    <script src="/js/fileuploader.js"></script>

    <link rel="stylesheet" href="/css/galleria.classic.css"/>
    <script src="/js/galleria.classic.min.js"></script>

    <script type="text/javascript">
        $(function () {
            var uploader = new qq.FileUploader({
                // pass the dom node (ex. $(selector)[0] for jQuery users)
                element:document.getElementById('file-uploader'),
                // path to server-side upload script
                action:"${it.uploadUrl}",
                onComplete:function (id, fileName, responseJSON) {
                    pollFor({
                        entity:"org.guiceae.main.model.Photo",
                        id:responseJSON.id,
                        query:{
                            type:"EXISTS"
                        }
                    }, function () {
                        location.reload();
                    });
                }
            });

            Galleria.loadTheme('/js/galleria.classic.min.js');
            Galleria.configure({
                thumbnails:true
            });
            if ($("#galleria-browse").size() > 0) {
                Galleria.run('#galleria-browse', {
                    imageCrop:false,
                    idleMode:true,
                    height:400,
                    width:500,
                    show_imagenav:true,
                    extend:function (options) {

                        this.bind('image', function (e) {
                            $(e.imageTarget).click(this.proxy(function () {
                                onClick(e.imageTarget.src);
                            }));
                        });
                    }
                });
            }
        });

        function onClick(src) {
        ${it.callbackCode}
            window.close();
        }
    </script>
</guiceae:head>
<body>
<div id="file-uploader">
    <noscript>
        <p>Please enable JavaScript to use file uploader.</p>
    </noscript>
</div>
<c:choose>
    <c:when test="${empty it.photos}">
        <h1>Не завантажено жодної фотографії</h1>
    </c:when>
    <c:otherwise>
        <div id="galleria-browse" style="height: 400px;">
            <c:forEach items="${it.photos}" var="photo">
                <a href="${photo.servingUrl}" data-url="${photo.servingUrl}" class="selectable-image">
                    <img id="photo${photo.id}"
                         data-title="${photo.title}"
                         data-description="<c:out value="${photo.description}"/>"
                         src="${photo.servingUrl}=s60">
                </a>
            </c:forEach>
        </div>
    </c:otherwise>
</c:choose>

<script type="text/javascript">
    $(function () {
        $(".selectable-image").each(function (i, v) {
            $(v).click(function () {
                onClick($(v).attr("data-url"));
            });
        })
    })
</script>
</body>
</html>
