<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户列表</title>
    <style>
        table {
            width: 700px;
            text-align: center;
            margin: auto;
        }

        th, td {
            height: 30px;
        }

        .userDel {
            margin-right: 10px;
        }

    </style>
</head>
<body>
<div id="divShow">
    <table>
        <thead>
        <tr>
            <th>用户名</th>
            <th>姓</th>
            <th>名</th>
            <th>邮箱</th>
            <th>电话</th>
            <th>状态</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody id="userTbody">
        </tbody>
    </table>
</div>

<%--
   Integer userId  String userName
   String userFirstName String userLastName
   String userEmail String userPassword
    String userPhone Integer userStatus;
--%>

<div id="divUpdate">
    <input type="hidden" id="userName"/>
    <p>姓：<input type="text" id="userFirstName"/></p>
    <p>名：<input type="text" id="userLastName"/></p>
    <p>邮箱：<input type="text" id="userEmail"/></p>
    <p>电话：<input type="text" id="userPhone"/></p>
    <p>状态<input type="text" id="userStatus"/></p>
    <p><input type="button" value="更新" id="btnUpdUser"/></p>
</div>

<script type="text/javascript" src="../../js/jquery-1.11.3.js"></script>
<script>
    $(function () {
        //数据渲染
        start();

        //修改点击事件
        $("#userTbody").on("click", ".userUpd", function (index, obj) {
            var updUserId = $(this).attr("updId");
            $("#userName").val(updUserId);

            $("#btnUpdUser").click(function () {
                $.ajax({
                    type: "put",
                    url: "/user/" + updUserId,
                    data: {
                        "userFirstName": $("#userFirstName").val(),
                        "userLastName": $("#userLastName").val(),
                        "userPhone": $("#userPhone").val(),
                        "userStatus": $("#userStatus").val(),
                        "userEmail":$("#userEmail").val()
                    },
                    success: function (data) {
                        alert(data);
                    }, error: function (err) {
                        console.log(err.responseText);
                    }
                });
            });

            //获得要修改的数据
            $.ajax({
                type: "get",
                url: "/user/" + updUserId,
                success: function (data) {
                    $("#userFirstName").val(data.userFirstName);
                    $("#userLastName").val(data.userLastName);
                    $("#userPhone").val(data.userPhone);
                    $("#userStatus").val(data.userStatus);
                    $("#userEmail").val(data.userEmail);
                },
                error: function (err) {
                    console.log(err.responseText);
                }
            });
        });

        //删除点击事件
        $("#userTbody").on("click", ".userDel", function (index, obj) {
            var delUserId = $(this).attr("delId");
            $.ajax({
                type: "delete",
                url: "/user/" + delUserId,
                success: function (data) {
                    if (data.msg == "success") {
                        start();
                    } else {
                        alert(data.msg);
                    }
                },
                error: function (err) {
                    console.log(err.responseText);
                }
            });
        });

    });

    function start() {
        $.ajax({
            type: "get",
            url: "/user",
            success: function (data) {
                $("#userTbody tr").remove();
                $.each(data, function (index, obj) {
                    // userId userName userFirstName
                    // userLastName userEmail userPassword userPhone userStatus;

                    var newTr = $("<tr/>");
                    newTr.append($("<td/>").text(obj.userName));
                    newTr.append($("<td/>").text(obj.userFirstName));
                    newTr.append($("<td/>").text(obj.userLastName));
                    newTr.append($("<td/>").text(obj.userEmail));
                    newTr.append($("<td/>").text(obj.userPhone));
                    newTr.append($("<td/>").text(obj.userStatus));
                    var newBtn = $("<input type='button' class='userDel' value='删除' delId='" + obj.userId + "'/>");
                    var newUpdBtn = $("  <input type='button' class='userUpd' value='修改' updId='" + obj.userName + "'/>");
                    newTr.append($("<td/>").append(newBtn).append(newUpdBtn));

                    $("#userTbody").append(newTr);
                });
            }, error: function (err) {
                console.log(err.responseText);
            }
        });
    }

</script>

</body>
</html>
