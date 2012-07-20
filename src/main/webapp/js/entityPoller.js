function pollFor(state, callback){
    $.ajax({
        url:"/app/entity/poll/",
        type:"POST",
        cache:false,
        dataType:"json",
        contentType:"application/json; charset=utf-8",
        data:JSON.stringify(state),
        success:function(data){
            if (data.status == "OK"){
                callback(data);
            }else{
                setTimeout(function(){pollFor(state, callback);}, 200);
            }
        },
        error: function(a,b,c){
            setTimeout(function(){pollFor(state, callback)}, 1000);
        }
    });
}