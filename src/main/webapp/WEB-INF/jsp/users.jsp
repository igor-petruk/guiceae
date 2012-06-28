<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="guiceae" uri="http://guiceae.org" %>
<html>
    <guiceae:head>
        <style>
            body { font-size: 72.5%; }
            div#users-contain { width: 550px; margin: 20px 0; }
            div#users-contain table { margin: 1em 0; border-collapse: collapse; width: 100%; }
            div#users-contain table td, div#users-contain table th { border: 1px solid #eee; padding: .6em 10px; text-align: left; }
        </style>

        <script>
            $(function() {
                var     email = $( "#email" ),
                        password = $( "#password" ),
                        rolesMap = {
                            admin:"Адміністратор",
                            cm:"Редактор змісту",
                            video:"Редактор відео"
                        };

                function reloadUsers(){
                    $.get("/app/users/allUsers",
                            function(data){
                                var tbody = $("table#users tbody");
                                tbody.html("");
                                for (i in data){
                                    function f(index){
                                        var user = data[index];
                                        var email = user.email;
                                        var tr = $("<tr/>");
                                        $("<td>"+user.email+"</td>").appendTo(tr);
                                        var ul = $("<ul/>");
                                        for (role in user.roles){
                                            $("<li>"+rolesMap[user.roles[role]]+"</li>").appendTo(ul);
                                        }
                                        var td = $("<td/>");
                                        ul.appendTo(td);
                                        td.appendTo(tr);

                                        var tdButtons = $("<td/>");
                                        $("<button/>").
                                            attr("id","edit"+index).
                                            text("Редагувати").
                                            button().
                                            appendTo(tdButtons).
                                            click(function(){
                                                editUser(email);
                                            });
                                        $("<button/>").
                                                text("Видалити").
                                                attr("id","delete"+index).
                                                button().
                                                appendTo(tdButtons).
                                                click(function(){
                                                    removeUser(email);
                                                });

                                        tdButtons.appendTo(tr);
                                        tr.appendTo(tbody);
                                    }
                                    f(i);
                                }
                            }, "json");
                }

                function editUser(email){
                    $([]).add($("#admin")).add($("#cm")).add($("#video")).attr("checked",false);
                    $("#email").attr("value","");
                    $("#oldEmail").attr("value","");
                    if (email!=null){
                        $("#oldEmail").attr("value",email);
                        $.get("/app/users/user/"+email,
                            function(data){
                                $("#email").attr("value",data.email);
                                $("#admin").attr("checked",$.inArray("admin", data.roles)!=-1);
                                $("#cm").attr("checked",$.inArray("cm", data.roles)!=-1);
                                $("#video").attr("checked",$.inArray("video", data.roles)!=-1);
                                $("#roles").buttonset("refresh");
                                $( "#dialog-form" ).dialog( "open" );
                            }, "json");
                    }else{
                        $("#roles").buttonset("refresh");
                        $( "#dialog-form" ).dialog( "open" );
                    }
                }

                function removeUser(email){
                    $.ajax({
                        url:"/app/users/user/"+email,
                        type:"DELETE",
                        success: function(){
                            reloadUsers();
                        }
                    });
                }

                reloadUsers();

                // TODO: Add validation

                $( "#dialog-form" ).dialog({
                    autoOpen: false,
                    height: 300,
                    width: 550,
                    modal: true,
                    buttons: {
                        "Зберегти": function() {
                            var rolesList = new Array();

                            if ($("#admin").attr("checked")) rolesList.push("admin");
                            if ($("#cm").attr("checked")) rolesList.push("cm");
                            if ($("#video").attr("checked")) rolesList.push("video");

                            var oldEmail = $("#email").attr("value");
                            var oldEmailField =  $("#oldEmail").attr("value");
                            if (oldEmailField!=""){
                                oldEmail = oldEmailField;
                            }
                            var form = {
                                email: $("#email").attr("value"),
                                roles: rolesList
                            };
                            $.ajax({
                                url:"/app/users/saveUser/"+oldEmail,
                                type:"POST",
                                data:JSON.stringify(form),
                                contentType:"application/json; charset=utf-8",
                                dataType:"json",
                                success: function(data){
                                    $("#dialog-form").dialog( "close" );
                                    reloadUsers();
                                }
                            });
                        },
                        "Відмініти": function() {
                            $( this ).dialog( "close" );
                        }
                    },
                    close: function() {
                        //allFields.val( "" ).removeClass( "ui-state-error" );
                    }
                });

                $("#roles").buttonset();

                $( "#create-user" )
                        .button()
                        .click(function() {
                            editUser(null);
                        });
            });
        </script>

    </guiceae:head>
    <body>
        <guiceae:menu/>

        <div id="users-contain" class="ui-widget">
            <table id="users" class="ui-widget ui-widget-content">
                <thead>
                <tr class="ui-widget-header ">
                    <th>Email</th>
                    <th>Ролі</th>
                    <th/>
                </tr>
                </thead>
                <tbody/>
            </table>
        </div>

        <button id="create-user">Додати користувача</button>

        <div id="dialog-form" title="Додати користувача">
            <form>
                <input id="oldEmail" name="oldEmail" type="hidden" value=""/>
                <fieldset>
                    <p>
                        <label for="email">Email</label>
                        <input type="text" name="email" id="email" value="" class="text ui-widget-content ui-corner-all" />
                    </p>
                    <label for="roles">Ролі користувача</label>
                    <div id="roles">
                        <input type="checkbox" id="admin" /><label for="admin">Адміністратор</label>
                        <input type="checkbox" id="cm" /><label for="cm">Редактор змісту</label>
                        <input type="checkbox" id="video" /><label for="video">Редактор відео</label>
                    </div>
                </fieldset>
            </form>
        </div>
    </body>
</html>
