<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>宠物商店登入</title>
</head>
<body>
<p><input type="text" id="userName" placeholder="登入账号"/></p>
<p><input type="password" id="password" placeholder="登入密码"/></p>
<p><input type="submit" id="btnLogin" value="登入"/></p>
<script type="text/javascript" src="../../js/jquery-1.11.3.js"></script>
<script>
    $(function () {
        //登入点击事件
        $("#btnLogin").click(function () {
            $.ajax({
                type: "get",
                url: "/user/login",
                data: {"username": $("#userName").val(), "password": $("#password").val()},
                success: function (data) {
                    if (data.msg === "success") {
                        //跳转成功页面
                        window.location.href="/userStart";
                    } else {
                        alert(data.msg);
                    }
                },
                error: function (err) {
                    console.log(err);
                }
            });
        });
    });
</script>
</body>
</html>
