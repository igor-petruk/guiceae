<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="guiceae" uri="http://guiceae.org" %>
<html>
<guiceae:head>
    <script type="text/javascript">
        function onClick(src){
            window.opener.CKEDITOR.tools.callFunction( ${it.funcNum}, src);
            window.close();
        }
    </script>
</guiceae:head>
    <body>
        <form action="${it.uploadUrl}" method="post" enctype="multipart/form-data">
            <input name="CKEditorFuncNum" value="${it.funcNum}" type="hidden"/>
            <input type="file" name="photos"/>
            <input type="submit" value="Upload"/>
        </form>
        <c:forEach items="${it.photos}" var="photo">
            <img class="selectable-image" id="photo${photo.id}" src="${photo.servingUrl}" width="200"/><br/>
        </c:forEach>
        <script type="text/javascript">
            $(function(){
                $(".selectable-image").each(function(i,v){
                    $(v).click(function(){
                        onClick($(v).attr("src"));
                    });
                })
            })
        </script>
    </body>
</html>
