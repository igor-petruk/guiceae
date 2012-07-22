<%@ tag pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="guiceae" uri="http://guiceae.org" %>
<%@ attribute name="article" required="true" type="org.guiceae.main.model.Article" %>

<script type="text/javascript">
    document.write(VK.Share.button({
                url: "<guiceae:siteName/>app/article/detail/${article.permalink}",
                title:"${article.title}",
                image:"${article.mainPhotoUrl}=s100",
                noparse: true},
            {type: "custom", text: "<img src='/css/images/vk.png'/>"}));
</script>

