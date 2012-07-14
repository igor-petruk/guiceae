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
                            toolbar : 'Basic',
                            uiColor : '#9AB8F3'
                        });
                CKEDITOR.replace( 'shortContent',
                        {
                            toolbar : 'Basic',
                            uiColor : '#9AB8F3'
                        });
            })
        </script>
    </guiceae:head>
    <body>
        <guiceae:menu/>

        <div>
            <form action="/app/article/save" method="post">
                <input name="id" type="hidden" value="${it.id}"/>
                <input name="feed" type="hidden" value="${it.feed}"/>

                <label for="title">Назва статті</label>
                <input id="title" name="title" type="text" value="${it.title}"/>
                <br/>

                <label for="permalink">Постійна назва</label>
                <input id="permalink" name="permalink" type="text" value="${it.permalink}"/>
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
