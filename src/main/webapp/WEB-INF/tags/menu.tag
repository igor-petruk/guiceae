<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="guiceae" uri="http://guiceae.org" %>

<guiceae:head>
    <script type="text/javascript" src="/js/jquery/interface.js"></script>
    <script type="text/javascript">
        $(document).ready(
                function () {
                    $('#dock').Fisheye(
                            {
                                maxWidth:50,
                                items:'a',
                                itemsText:'span',
                                container:'.dock-container',
                                itemWidth:40,
                                proximity:90,
                                halign:'center'
                            }
                    );
                    $('#login').Fisheye(
                            {
                                maxWidth:50,
                                items:'a',
                                itemsText:'span',
                                container:'.login-dock-container',
                                itemWidth:40,
                                proximity:90,
                                valign:'top',
                                halign:'right'
                            }
                    )
                }
        );

    </script>
</guiceae:head>

<div class="dock" id="dock">
    <div class="dock-container">
        <a class="dock-item" href="/app/index"><img src="/css/images/dock-menu/home.png"
                                                    alt="home"/><span>Home</span></a>
        <a class="dock-item" href="/app/contacts"><img src="/css/images/dock-menu/email.png" alt="contact"/><span>Contact</span></a>
        <guiceae:rolesOnly roles="admin">
            <a class="dock-item" href="/app/users"><img src="/css/images/dock-menu/profiles.png" alt="contact"/><span>Users</span></a>
            <a class="dock-item" href="/app/photo/newPhotoPage"><img src="/css/images/dock-menu/addPhoto.png"
                                                                     alt="contact"/><span>Add photo</span></a>
            <a class="dock-item" href="/app/photo/albums"><img src="/css/images/dock-menu/albums.png"
                                                               alt="contact"/><span>Add album</span></a>
        </guiceae:rolesOnly>
        <a class="dock-item" href="#"><img src="/css/images/dock-menu/rss.png" alt="rss"/><span>RSS</span></a>
    </div>
</div>

<div id="login" class="login-dock">
    <div class="login-dock-container">
        <guiceae:googleLogin/>
    </div>
</div>