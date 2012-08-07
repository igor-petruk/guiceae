<!DOCTYPE HTML PUBLIC "-//W3//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<%--
  User: boui
  Date: 6/29/12
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="guiceae" uri="http://guiceae.org" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<guiceae:head/>
<body>
<div id="head">
    <guiceae:quick-panel/>
</div>
<guiceae:new-menu/>

<div class="newAlbumForm">
    <form action="/app/album/addNew" method="POST">
        <div style="float:left; border: 1px solid #AAA">

            <input type="hidden" name="id" value="${it.id}"/>

            <div style="float:left; display: block">
                <label for="albumTitle">Назва фотоальбому</label>
                <input type="text" id="albumTitle" name="title" maxlength="200" value="${it.title}"/>
            </div>

            <div style="float:left; display: block">
                <label for="albumDesc">Опис фотоальбому</label>
                <input type="text" id="albumDesc" type="text" name="description" maxlength="400"
                       value="${it.description}"/>
            </div>

            <c:choose>
                <c:when test="${empty it.id}">
                    <input type="submit" value="Додати новий фотоальбом"/>
                </c:when>
                <c:otherwise>
                    <input type="submit" value="Редагувати фотоальбом"/>
                </c:otherwise>
            </c:choose>
        </div>
    </form>
</div>

<guiceae:footer/>
</body>
</html>