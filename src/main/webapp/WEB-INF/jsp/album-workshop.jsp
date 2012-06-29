<%--
  User: boui
  Date: 6/28/12
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="guiceae" uri="http://guiceae.org" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <guiceae:head/>
    <guiceae:photo-scripts/>


    <script type="text/javascript" charset="utf-8">
        $(document).ready(function () {
            $("a[rel^='prettyPhoto']").each(
                    function () {
                        $(this).prettyPhoto();
                    }
            );

        });
    </script>

    <title>
        Album workshop page
    </title>
</head>
<body>
<div class="content ui-widget-content ui-widget">
    <c:forEach var="photo" items="${it}">
        <a href="${photo.servingUrl}" rel="prettyPhoto[pp_gal]" title="${photo.title}"><img
                src="${photo.servingUrl}=s300" alt="${photo.description}"/></a>
    </c:forEach>
    <a href="/app/photo/form">Another photo</a>
</div>
</body>
</html>