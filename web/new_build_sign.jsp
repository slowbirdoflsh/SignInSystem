<%--
  Created by IntelliJ IDEA.
  User: lingsh
  Date: 19-9-7
  Time: 下午1:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html class="uk-height-1-1 uk-notouch">
<head>
    <title>新建签到记录</title>
    <meta charset="utf-8">
    <link type="text/css" rel="stylesheet" href="styles/uikit-2.25.0/css/uikit.gradient.min.css"/>
    <link type="text/css" rel="stylesheet" href="styles/uikit-2.25.0/css/components/datepicker.gradient.min.css"/>
    <link type="text/css" rel="stylesheet" href="styles/uikit-2.25.0/css/components/autocomplete.gradient.min.css"/>
    <script src="styles/vendor/jquery.js"></script>
    <script src="styles/vendor/jquery.cookie.min.js"></script>
    <script src="styles/uikit-2.25.0/js/uikit.min.js"></script>
    <script src="styles/uikit-2.25.0/js/components/datepicker.min.js"></script>
    <script src="styles/uikit-2.25.0/js/components/autocomplete.min.js"></script>
    <script src="styles/uikit-2.25.0/js/components/timepicker.min.js"></script>
    <script src="styles/js/validate.js"></script>
    <script src="styles/js/signup.js"></script>
    <script src="styles/js/ajax.js"></script>
    <script>
        $(window).ready(function () {
            are_you_login();
        });
    </script>
</head>
<body class="uk-height-1-1">
<div class="uk-vertical-align uk-text-center uk-height-1-1">
    <div class="uk-vertical-align-middle" style="width: 450px;">
        <form class="uk-panel uk-panel-box uk-form" action="main.jsp" method="post" onsubmit="return new_build_sign()">
            <h3>添加记录</h3>
            <input type="hidden" id="auth" name="auth" value="user"/>
            <div class="uk-form-row">
                <label class="uk-form-label uk-text-large uk-float-left">用户账号</label>
                <input id="account" name="account" class="uk-width-1-1 uk-form-large" type="text"
                       placeholder="用户账号, 不少于4个字符">
            </div>
            <div class="uk-form-row">
                <label class="uk-form-label uk-text-large uk-float-left">签到时间</label>
                <input id="signDate" name="signDate"
                       class="uk-width-1-1 uk-form-large"
                       data-uk-datepicker="{format:'YYYY-MM-DD'}" placeholder="用户签到日期">
                <input id="signTime" name="signDate"
                       class="uk-width-1-1 uk-form-large"
                       data-uk-timepicker placeholder="用户签到时间">
            </div>
            <div class="uk-form-row">
                <button class="uk-width-1-1 uk-button uk-button-primary uk-button-large" type="submit">添加</button>
                <span id="checkFormResult" style="color: red"></span>
            </div>
            <div class="uk-form-row uk-text-small">
                <a class="uk-float-right uk-link uk-link-muted" href="main.jsp">返回主界面</a>
            </div>
        </form>
    </div>
</div>
</body>
</html>