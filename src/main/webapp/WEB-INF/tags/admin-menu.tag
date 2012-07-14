<%@ taglib prefix="guiceae" uri="http://guiceae.org" %>
<guiceae:rolesOnly roles="admin">
    <div class="admin-menu">
        <div><a href="/app/users">Users</a></div>
        <div><a href="/app/photo/new">Add photo</a></div>
        <div><a href="/app/album/new">Add album</a></div>
        <div><a href="/app/article/new">Add article</a></div>
        <div><a href="/app/feed/new">Add feed</a></div>
        <div><a href="/app/album/all">Albums</a></div>
    </div>
</guiceae:rolesOnly>

