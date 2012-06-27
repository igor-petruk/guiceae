<%@ page import="com.google.appengine.api.blobstore.BlobstoreService" %>
<%@ page import="com.google.appengine.api.blobstore.BlobstoreServiceFactory" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Upload photo</title>
</head>
<body>
<%BlobstoreService blobstorageService = BlobstoreServiceFactory.getBlobstoreService();%>

<form action="<%= blobstorageService.createUploadUrl("/app/upload")%>" method="POST"
      enctype="multipart/form-data">
    <input type="file" name="photos"/>
    <input type="submit" value="Upload"/>
</form>

</body>
</html>