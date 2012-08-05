<!DOCTYPE HTML PUBLIC "-//W3//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="guiceae" uri="http://guiceae.org" %>

<html>
<guiceae:head/>
<body>
<div id="head">
    <guiceae:quick-panel/>
</div>
<guiceae:new-menu/>
<div id="content">
    <div id="content_cen">
        <div id="content_sup">
            <guiceae:googleLogin/>
        </div>
    </div>
</div>
<guiceae:footer/>
</body>
</html>