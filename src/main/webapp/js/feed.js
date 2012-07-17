function registerDelete(id){
    $("#delete"+id).click(function(){
        $.ajax({
            url:"/app/article/delete/"+id,
            type:"DELETE",
            cache:false,
            dataType:"json",
            success:function(data){
                $("#article"+id).remove();
            }
        });
    });
}

function registerSimpleDelete(id, feed){
    $("#delete"+id).click(function(){
        $.ajax({
            url:"/app/article/delete/"+id,
            type:"DELETE",
            cache:false,
            dataType:"json",
            success:function(data){
                window.location="/app/feed/"+feed;
            }
        });
    });
}

function registerPublish(id){
    $("#publish"+id).click(function(){
        $.ajax({
            url:"/app/article/publish/"+id,
            type:"POST",
            cache:false,
            dataType:"json",
            success:function(data){
                setTimeout(function(){location.reload();}, 1000);
            }
        });
    });
}

function registerPublishQuestion(id){
    $("#publish"+id).click(function(){
        $.ajax({
            url:"/app/feedback/publish/"+id,
            type:"POST",
            cache:false,
            dataType:"json",
            success:function(data){
                setTimeout(function(){location.reload();}, 1000);
            }
        });
    });
}