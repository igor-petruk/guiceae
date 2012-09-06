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
</guiceae:head>

<body>

<div id="head">
    <guiceae:quick-panel/>
</div>

<guiceae:new-menu/>

<div id="content">
    <div id="content_cen">
        <div id="content_sup">
            <div class="new-photo">
                <%BlobstoreService blobstorageService = BlobstoreServiceFactory.getBlobstoreService();%>
                <form action="<%= blobstorageService.createUploadUrl("/app/upload")%>" method="POST"
                      enctype="multipart/form-data">
                    <input type="file" name="photos"/>
                    <input type="submit" value="Upload"/>
                </form>
            </div>
        </div>
    </div>
</div>
<guiceae:footer/>
<%--<guiceae:feed shortView="false" pagesCount="true" currentFirst="true" feed="" feedName="news"/>--%>

</body>
</html>