<%--
  Created by IntelliJ IDEA.

  管理员注册功能 与用户注册没有区别...
  因为此处取巧 管理员是用户的子类型 后期需要被修改 管理员注册需要更复杂一些
  但都是用嵌入的方式

  User: lingsh
  Date: 19-9-4
  Time: 上午10:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html class="uk-height-1-1 uk-notouch">
<head>
    <title>管理员注册</title>
    <meta charset="utf-8">
    <link type="text/css" rel="stylesheet" href="../styles/uikit-2.25.0/css/uikit.gradient.min.css"/>
    <link type="text/css" rel="stylesheet" href="../styles/uikit-2.25.0/css/components/form-password.min.css"/>
    <script src="../styles/vendor/jquery.js"></script>
    <script src="../styles/uikit-2.25.0/js/uikit.min.js"></script>
    <script src="../styles/uikit-2.25.0/js/components/form-password.js"></script>
    <script src="../styles/js/validate.js"></script>
    <script src="../styles/js/signup.js"></script>
</head>
<body class="uk-height-1-1">
<div class="uk-vertical-align uk-text-center uk-height-1-1">
    <div class="uk-vertical-align-middle" style="width: 450px;">
        <form class="uk-panel uk-panel-box uk-form" action="../action/doSignUp.jsp" method="post" onsubmit="return signup()">
            <h2>注册新用户</h2>
            <input type="hidden" id="auth" name="auth" value="admin"/>
            <div class="uk-form-row">
                <label class="uk-form-label uk-text-large uk-float-left">账号</label>
                <span id="checkAccountResult" style="color: red" class="uk-float-right"></span>
                <input id="account" name="account" class="uk-width-1-1 uk-form-large" type="text"
                       placeholder="登录账号, 不少于4个字符" onblur="checkAccount(this.value)">
            </div>
            <div class="uk-form-password uk-form-row" style="display: block">
                <label class="uk-form-label uk-text-large uk-float-left">密码</label>
                <span id="checkPasswordResult" style="color: red" class="uk-float-right"></span>
                <input id="password" name="password" class="uk-width-1-1 uk-form-large" type="password"
                       placeholder="登录密码, 不少于6个字符" onblur="checkPassword(this.value)">
                <a href="" class="uk-form-password-toggle" data-uk-form-password>Show</a>
            </div>
            <div class="uk-form-row uk-form-password" style="display: block">
                <label class="uk-form-label uk-text-large uk-float-left">确认密码</label>
                <span id="checkPasswordEqualResult" style="color: red" class="uk-float-right"></span>
                <input id="password2" name="password" class="uk-width-1-1 uk-form-large" type="password"
                       placeholder="请再次确认所输入的密码" onblur="checkPasswordEqual(this.value)">
                <a href="" class="uk-form-password-toggle" data-uk-form-password>Show</a>
            </div>
            <div class="uk-form-row">
                <label class="uk-form-label uk-text-large uk-float-left">姓名</label>
                <span id="checkNameResult" style="color: red" class="uk-float-right"></span>
                <input id="name" name="name" class="uk-width-1-1 uk-form-large" type="text"
                       placeholder="用户昵称, 不少于6个字符" onblur="checkName(this.value)">
            </div>
            <div class="uk-form-row">
                <button class="uk-width-1-1 uk-button uk-button-primary uk-button-large" type="submit">注册</button>
                <span id="checkFormResult" style="color: red"></span>
            </div>
            <div class="uk-form-row">
                <span class="uk-float-left" style="color: red">
                    <%=session.getAttribute("error") == null ? "" : session.getAttribute("error")%>
                </span>
            </div>
            <div class="uk-form-row uk-text-small">
                <a class="uk-float-right uk-link uk-link-muted" href="login.jsp">返回登录</a>
            </div>
        </form>
    </div>
</div>
</body>
</html>

<%
    // 用完session就删掉
    session.removeAttribute("error");
%>