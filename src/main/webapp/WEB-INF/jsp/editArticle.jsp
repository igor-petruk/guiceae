<!DOCTYPE HTML PUBLIC "-//W3//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="guiceae" uri="http://guiceae.org" %>
<html>

<guiceae:head>
    <script type="text/javascript" src="/ckeditor/ckeditor.js"></script>
    <script type="text/javascript">
        $(function () {
            CKEDITOR.replace('content',
                    {
                        toolbar:'CustomToobar',
                        uiColor:'#9AB8F3',
                        filebrowserBrowseUrl:'/app/album/browse/0?mode=ckeditor'
                    });
            CKEDITOR.replace('shortContent',
                    {
                        toolbar:'CustomToobar',
                        uiColor:'#9AB8F3',
                        filebrowserBrowseUrl:'/app/album/browse/0?mode=ckeditor'
                    });
            var validator = $("#articleForm").validate({
                rules:{
                    title:"required",
                    permalink:{
                        required:true,
                        minlength:2,
                        remote:"/app/article/validatePermalink/${it.id}/<c:out value='${it.permalink}'/>"
                    }
                },
                messages:{
                    title:"Введіть назву статті",
                    permalink:"Така адреса вже існує"
                },
                success:function (label) {
                    // set &nbsp; as text for IE
                    label.html("&nbsp;").addClass("checked");
                }
            });
        })

        function imageSelected(src) {
            $("#mainImageImg").attr("src", src);
            $("#mainImage").attr("value", src);
        }
    </script>
</guiceae:head>
<body>
<div>
    <form id="articleForm" action="/app/article/save" method="post">
        <input name="id" type="hidden" value="${it.id}"/>
        <input name="feed" type="hidden" value="<c:out value='${it.feed}'/>"/>

        <label for="title">Назва статті</label>
        <input id="title" name="title" type="text" value="<c:out value='${it.title}'/>"/>
        <br/>

        <label for="permalink">Постійна назва</label>
        <input id="permalink" name="permalink" type="text" value="<c:out value='${it.permalink}'/>"/>
        <br/>

        <p>
            <img id="mainImageImg" src="${it.mainPhotoUrl}" width="200"/>
            <input type="hidden" name="mainImage" id="mainImage" value="${it.mainPhotoUrl}"/>
            <a id="selectPhotoLink" href="/app/album/browse/0?mode=mainPhoto">Select photo</a>
            <script type="text/javascript">
                jQuery('#selectPhotoLink').live('click', function () {
                    newwindow = window.open($(this).attr('href'), '', 'height=500,width=600');
                    if (window.focus) {
                        newwindow.focus()
                    }
                    return false;
                });
            </script>
        </p>

        <label for="shortContent">Короткий зміст</label>
        <textarea id="shortContent" name="shortContent">
            ${it.shortContent}
        </textarea>

        <label for="content">Зміст статті</label>
        <textarea id="content" name="editableContent">
            ${it.editableContent}
        </textarea>

        <input type="submit"/>

    </form>
</div>
</body>
</html>
