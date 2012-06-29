<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="guiceae" uri="http://guiceae.org" %>

<table border="0" width="99%">
    <col align="left"/>
    <col align="right" width="300"/>
    <tr>
        <td><a href="/app/index">Home</a></td>
        <guiceae:rolesOnly roles="admin">
            <td><a href="/app/users">Users</a></td>
            <td><a href="/app/photo/form">Add photo</a></td>
            <td><a href="/app/photo/albums">Albums</a></td>
        </guiceae:rolesOnly>
        <td style="text-align: right;"><guiceae:googleLogin/></td>
    </tr>
</table>

