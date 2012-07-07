<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="guiceae" uri="http://guiceae.org" %>

<%@ attribute name="article" required="true" type="org.guiceae.main.model.Article" %>

    <div>
        <h2><a href="/app/article/${article.permalink}">${article.title}</a></h2>
        <div id="article${article.id}">
            ${article.content}
        </div>
        <div style="float: right;">
            Created by ${article.author}, ${article.created}
        </div>
        <guiceae:rolesOnly roles="cm">
            <div>
                <button id="edit${article.id}">Edit</button>

                <script type="text/javascript">
                    $("#edit${article.id}").button().click(function(){
                       var content = $("#article${article.id}");
                       var contentHtml = content.html();
                       content.html("");
                       var ta = $("<textarea/>").attr("id","textarea${article.id}").text(contentHtml);
                       ta.appendTo(content);
                        CKEDITOR.replace( 'textarea${article.id}',
                                {
                                    toolbar : 'Basic',
                                    uiColor : '#9AB8F3'
                                });
                        $("#edit${article.id}").hide();
                    })
                </script>
            </div>
        </guiceae:rolesOnly>
    </div>
