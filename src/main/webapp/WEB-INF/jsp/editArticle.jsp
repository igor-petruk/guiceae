<!DOCTYPE HTML PUBLIC "-//W3//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="guiceae" uri="http://guiceae.org" %>
<html>

<guiceae:head>
    <script type="text/javascript" src="/ckeditor/ckeditor.js"></script>
    <script type="text/javascript">
        $(function () {
            CKEDITOR.replace('articlecontent',
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
            $("#datepicker").datepicker();
        });

        function imageSelected(src) {
            if ($("#no-photo").length != 0) {
                $("#main-photo-container").prepend($("<img id='mainImageImg'/>"));
                $("#no-photo").remove();
            }
            $("#mainImageImg").attr("src", src);
            $("#mainImage").attr("value", src);
        }
    </script>
</guiceae:head>
<guiceae:body>

    <div id="head">
        <guiceae:quick-panel/>
    </div>

    <div id="personal-not-main">
        <div class="name">Персональний сайт Івана Куровського</div>
        <div class="background"><img src="/css/images/system/personal_not_main.png"/></div>
    </div>

    <guiceae:new-menu/>

    <div id="content" style="background-image: none; opacity:1">
        <div id="content_cen">
            <div id="content_sup">

                <div class="view-center-place" style="background: none;">

                    <a class="back" href="/app/feed/${it.feed}">Назад до стрічки</a>

                    <div class="editArticle">
                        <form id="articleForm" action="/app/article/save" method="post">
                            <input name="id" type="hidden" value="${it.id}"/>
                            <input name="feed" type="hidden" value="<c:out value='${it.feed}'/>"/>

                            <label class="aricle-name-label" for="title">Назва статті</label>
                            <input class="aricle-name-input" id="title" name="title" type="text"
                                   value="<c:out value='${it.title}'/>"/>

                            <label class="aricle-link-label" for="permalink">Постійна назва</label>
                            <input class="aricle-link-input" id="permalink" name="permalink" type="text"
                                   value="<c:out value='${it.permalink}'/>"/>

                            <label class="aricle-link-label" for="datepicker">Дата для відображення</label>
                            <input class="aricle-link-input" id="datepicker" name="toView" type="text"
                                   value="<c:out value='${it.toView}'/>"/>

                            <div class="main-photo-container" id="main-photo-container">

                                <c:choose>
                                    <c:when test="${it.mainPhotoUrl==null||it.mainPhotoUrl==''}">
                                        <img id="no-photo" src="/css/images/system/nophoto.png" width="100"
                                             alt="Немає фотографії"/>
                                    </c:when>
                                    <c:otherwise>
                                        <img id="mainImageImg" src="${it.mainPhotoUrl}" width="200"/>
                                    </c:otherwise>
                                </c:choose>

                                <input type="hidden" name="mainImage" id="mainImage" value="${it.mainPhotoUrl}"/>

                                <a id="selectPhotoLink" href="/app/album/browse/0?mode=mainPhoto">Вибрати фото</a>

                                <script type="text/javascript">
                                    jQuery('#selectPhotoLink').live('click', function () {
                                        newwindow = window.open($(this).attr('href'), '', 'height=500,width=600');
                                        if (window.focus) {
                                            newwindow.focus()
                                        }
                                        return false;
                                    });
                                </script>
                            </div>

                            <div style="float: left; margin-top: 25px;">
                                <label for="shortContent">Короткий зміст</label>
                                <textarea id="shortContent" name="shortContent">
                                        ${it.shortContent}
                                </textarea>

                                <label for="content">Зміст статті</label>
                                <textarea id="articlecontent" name="editableContent">
                                        ${it.editableContent}
                                </textarea>

                                <input type="submit"/>
                            </div>
                        </form>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <guiceae:footer/>
</guiceae:body>
</html>
