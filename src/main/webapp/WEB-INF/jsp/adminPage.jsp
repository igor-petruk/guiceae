<!DOCTYPE HTML PUBLIC "-//W3//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<%--
  User: boui
  Date: 7/17/12
--%>
<%@ page import="com.google.appengine.api.blobstore.BlobstoreService" %>
<%@ page import="com.google.appengine.api.blobstore.BlobstoreServiceFactory" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="guiceae" uri="http://guiceae.org" %>

<html>
<guiceae:head>
    <title>Admin page</title>
</guiceae:head>
<body>

<guiceae:quick-panel/>

<div class="newAlbumForm">
    <form action="/app/album/addNew" method="POST">
        <table>
            <tr>
                <th>Album title</th>
                <th>Album description</th>
                <th>
                    <button>Add new album</button>
                </th>
            </tr>
            <tr>
                <td><input type="text" name="title" maxlength="200"/></td>
                <td><input type="text" name="description" maxlength="200"/></td>
            </tr>
        </table>
    </form>
</div>

<div class="new-photo">
    <%BlobstoreService blobstorageService = BlobstoreServiceFactory.getBlobstoreService();%>
    <form action="<%= blobstorageService.createUploadUrl("/app/upload")%>" method="POST"
          enctype="multipart/form-data">
        <input type="file" name="photos"/>
        <input type="submit" value="Upload"/>
    </form>
</div>


</body>
</html>