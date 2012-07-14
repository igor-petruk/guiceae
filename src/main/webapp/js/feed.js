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