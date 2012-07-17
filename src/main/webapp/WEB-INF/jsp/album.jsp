<%--
  User: boui
  Date: 6/29/12
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="guiceae" uri="http://guiceae.org" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<guiceae:head/>
<body>
<div class="newAlbumForm">
    <form action="/app/album/addNew" method="POST">
        <input type="text" name="title" maxlength="200"/>
        <input type="text" name="description" maxlength="200"/>
        <button>Add new album</button>
    </form>
</div>
</body>
</html>