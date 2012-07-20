<%@ page import="com.google.appengine.api.blobstore.BlobstoreService" %>
<%@ page import="com.google.appengine.api.blobstore.BlobstoreServiceFactory" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="guiceae" uri="http://guiceae.org" %>
<html>

    <guiceae:head>
        <script type="text/javascript" src="/ckeditor/ckeditor.js"></script>
        <script type="text/javascript">
            $(function(){
                CKEDITOR.replace( 'content',
                        {
                            toolbar : 'CustomToobar',
                            uiColor : '#9AB8F3',
                            filebrowserBrowseUrl : '/app/album/browse/0?mode=ckeditor'
                        });
                CKEDITOR.replace( 'shortContent',
                        {
                            toolbar : 'CustomToobar',
                            uiColor : '#9AB8F3',
                            filebrowserBrowseUrl : '/app/album/browse/0?mode=ckeditor'
                        });
            })
        </script>
    </guiceae:head>
    <body>
        <guiceae:menu/>

        <div>
            <form action="/app/article/save" method="post">
                <input name="id" type="hidden" value="${it.id}"/>
                <input name="feed" type="hidden" value="<c:out value='${it.feed}'/>"/>

                <label for="title">Назва статті</label>
                <input id="title" name="title" type="text" value="<c:out value='${it.title}'/>"/>
                <br/>

                <label for="permalink">Постійна назва</label>
                <input id="permalink" name="permalink" type="text" value="<c:out value='${it.permalink}'/>"/>
                <br/>

                <label for="shortContent">Короткий зміст</label>
                <textarea id="shortContent" name="shortContent">
                    ${it.shortContent}
                </textarea>

                <label for="content">Зміст статті</label>
                <textarea id="content" name="content">
                    ${it.content}
                </textarea>

                <input type="submit"/>

            </form>
        </div>
    </body>
</html>
