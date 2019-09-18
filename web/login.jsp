<%--
  Created by IntelliJ IDEA.
  User: lingsh
  Date: 19-9-9
  Time: 上午9:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html class="uk-height-1-1 uk-notouch">
<head>
    <title>用户登录</title>
    <meta charset="utf-8">
    <link type="text/css" rel="stylesheet" href="styles/uikit-2.25.0/css/uikit.gradient.min.css"/>
    <link type="text/css" rel="stylesheet" href="styles/uikit-2.25.0/css/components/form-password.min.css"/>
    <link type="text/css" rel="stylesheet" href="styles/uikit-2.25.0/css/components/form-advanced.min.css"/>
    <script src="styles/vendor/jquery.js"></script>
    <script src="styles/vendor/jquery.cookie.min.js"></script>
    <script src="styles/uikit-2.25.0/js/uikit.min.js"></script>
    <script src="styles/uikit-2.25.0/js/components/form-password.js"></script>
    <script src="styles/js/validate.js"></script>
    <script src="styles/js/login.js"></script>
    <script src="styles/js/ajax.js"></script>
    <script>
        $(document).ready(
            function () {
                del_cur_auth();

                var rem = $.cookie('rem');
                if (rem) {
                    $("#rem").prop("checked", true);
                    $("#account").val($.cookie("account"));
                    $("#password").val($.cookie("password"));
                }
                // 判断是否已经登录 无需重复登录
                valid(function () {
                    },
                    function () {
                        alert("你已经登录了!");
                        window.location.replace("main.jsp");
                    });
            }
        )
    </script>
</head>
<body class="uk-height-1-1">
<div class="uk-vertical-align uk-text-center uk-height-1-1">
    <div class="uk-vertical-align-middle" style="width: 250px;">
        <form class="uk-panel uk-panel-box uk-form" action="main.jsp" method="post" onsubmit="return login()">
            <h2>欢迎登录</h2>
            <div class="uk-form-row">
                <input id="account" name="account" class="uk-width-1-1 uk-form-large"
                       type="text" placeholder="账号" onblur="checkAccount(this.value)">
            </div>
            <div class="uk-form-row">
                <span id="checkAccountResult" style="color: red" class="uk-float-right"></span>
            </div>
            <div class="uk-form-row uk-form-password">
                <input id="password" name="password" class="uk-width-1-1 uk-form-large"
                       type="password" placeholder="密码" onblur="checkPassword(this.value)">
                <a href="" class="uk-form-password-toggle" data-uk-form-password>Show</a>
            </div>
            <div class="uk-form-row">
                <span id="checkPasswordResult" style="color: red" class="uk-float-right"></span>
            </div>
            <div class="uk-form-row">
                <label class="uk-float-right"> <input id="rem" name="rem" value="1" type="checkbox"> 记住密码</label>
            </div>
            <div class="uk-form-row">
                <button class="uk-width-1-1 uk-button uk-button-primary uk-button-large" type="submit">登录</button>
            </div>
            <div class="uk-form-row uk-text-small">
                <a class="uk-float-left uk-link uk-link-muted" href="signup.jsp" onclick="set_cur_auth()">注册</a>
                <a class="uk-float-right uk-link uk-link-muted" href="forget.jsp" onclick="set_cur_auth()">忘记密码</a>
            </div>
            <div class="uk-form-row uk-text-small uk-form-controls uk-form-controls-text">
                <label><input type="radio" name="auth" value="user" checked="checked"/>我是学生</label>
                <label><input type="radio" name="auth" value="admin"/>我是管理员</label>
            </div>
        </form>
    </div>
</div>
</body>
</html>