<!DOCTYPE HTML PUBLIC "-//W3//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<%--
  User: boui
  Date: 6/28/12
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="guiceae" uri="http://guiceae.org" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <guiceae:head>
        <guiceae:photo-scripts/>

    <title>
        Album workshop page
    </title>
    </guiceae:head>
<body>

<guiceae:admin-menu/>
<c:forEach var="album" items="${it['albums']}">
    <tr>
        <td>
            <div class="navigation-container">
                <a class="pageLink prev" style="visibility: hidden;" href="#" title="Previous Page"></a>

                <div id="${album.id}" class="album navigation">
                    <div id="album-gallery${album.id}" class="album-gallery">
                        <ul class="thumbs noscript"></ul>
                    </div>
                </div>
                <a class="pageLink next" style="visibility: hidden;" href="#" title="Next Page"></a>
            </div>
        </td>
        <td>
            <div class="album-caption">
                <div class="album-title"><c:out value="${album.title}"/></div>
                <div class="album-desc"><c:out value="${album.description}"/></div>
                <div class="admin-controls" style="font-size: large;">
                    <a href="/app/album/update?id=${album.id}">Update album</a>
                    <a href="/app/album/delete?id=${album.id}">Delete album</a>
                </div>
            </div>
        </td>
    </tr>
</c:forEach>
</table>

<div style="display:none;">
    <c:forEach var="photo" items="${it['photos']}">
        <div id="${photo.albumId}" class="photo">
            <a href="${photo.servingUrl}" class="thumb" title='<c:out value="${photo.title}"/>'><img
                    src="${photo.servingUrl}=s200" alt='<c:out value="${photo.description}"/>'/></a>

            <div class="caption">
                <div class="image-title"><c:out value="${photo.title}"/></div>
                <div class="image-desc"><c:out value="${photo.description}"/></div>
                <div class="admin-controls">
                    <a href="/app/photo/update?id=${photo.id}">Update photo</a>
                    <a href="/app/photo/delete?id=${photo.id}">Delete photo</a>
                </div>
            </div>
        </div>
    </c:forEach>
</div>


</body>
</html>