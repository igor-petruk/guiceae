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
                pollFor({
                    entity: "org.guiceae.main.model.Article",
                    id: id,
                    query: {
                        type: "NEXISTS"
                    }
                },function(){
                    window.location="/app/feed/"+feed;
                });
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
                pollFor({
                    entity: "org.guiceae.main.model.Article",
                    id: id,
                    query: {
                        type: "FIELD",
                        name: "state",
                        value: "PUBLISHED"
                    }
                },function(){
                    location.reload();
                });
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
                pollFor({
                    entity: "org.guiceae.main.model.Feedback",
                    id: id,
                    query: {
                        type: "FIELD",
                        name: "state",
                        value: "PUBLISHED"
                    }
                },function(){
                    location.reload();
                });
            }
        });
    });
}

function registerSimpleFeedbackDelete(id, feed){
    $("#delete"+id).click(function(){
        $.ajax({
            url:"/app/feedback/delete/"+id,
            type:"DELETE",
            cache:false,
            dataType:"json",
            success:function(data){
                pollFor({
                    entity: "org.guiceae.main.model.Feedback",
                    id: id,
                    query: {
                        type: "NEXISTS"
                    }
                },function(){
                    window.location="/app/feedback/view/"+feed;
                });
            }
        });
    });
}

