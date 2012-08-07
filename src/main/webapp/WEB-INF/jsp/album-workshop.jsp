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
<div id="head">
    <guiceae:quick-panel/>
</div>
<guiceae:new-menu/>
<guiceae:admin-menu/>

<div style="float:left">
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