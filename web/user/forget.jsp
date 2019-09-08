<%--
  Created by IntelliJ IDEA.
  User: lingsh
  Date: 19-9-5
  Time: 上午11:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>找回密码</title>
    <meta charset="utf-8">
    <link type="text/css" rel="stylesheet" href="../styles/uikit-2.25.0/css/uikit.gradient.min.css"/>
    <link type="text/css" rel="stylesheet" href="../styles/uikit-2.25.0/css/components/form-password.min.css"/>
    <script src="../styles/vendor/jquery.js"></script>
    <script src="../styles/uikit-2.25.0/js/uikit.min.js"></script>
    <script src="../styles/uikit-2.25.0/js/components/form-password.js"></script>
    <script src="../styles/js/validate.js"></script>
    <script src="../styles/js/forget.js"></script>
</head>
<body class="uk-height-1-1">
<div class="uk-vertical-align uk-text-center uk-height-1-1">
    <div class="uk-vertical-align-middle" style="width: 450px;">
        <form class="uk-panel uk-panel-box uk-form" action="../action/doForget.jsp" method="post" onsubmit="return signup()">
            <h2>找回密码</h2>
            <input type="hidden" id="auth" name="auth" value="user"/>
            <div class="uk-form-label">
                <label class="uk-text-small uk-text-right">通过账号和姓名找回密码</label>
            </div>
            <div class="uk-form-row">
                <label class="uk-form-label uk-text-large uk-float-left">账号</label>
                <span id="checkAccountResult" style="color: red" class="uk-float-right"></span>
                <input id="account" name="account" class="uk-width-1-1 uk-form-large" type="text"
                       placeholder="登录账号, 不少于4个字符" onblur="checkAccount(this.value)">
            </div>
            <div class="uk-form-row">
                <label class="uk-form-label uk-text-large uk-float-left">姓名</label>
                <span id="checkNameResult" style="color: red" class="uk-float-right"></span>
                <input id="name" name="name" class="uk-width-1-1 uk-form-large" type="text"
                       placeholder="用户姓名, 不少于6个字符" onblur="checkName(this.value)">
            </div>
            <div class="uk-form-row">
                <button class="uk-width-1-1 uk-button uk-button-primary uk-button-large" type="submit">找回</button>
                <span id="checkFormResult" style="color: red"></span>
            </div>
            <div class="uk-form-row">
                <span id="feedback" class="uk-float-left" style="color: red">
                    <%=session.getAttribute("feedback") == null ? "抱歉你的输入有误" : session.getAttribute("feedback")%>
                </span>
            </div>
            <div class="uk-form-row uk-text-small">
                <a class="uk-float-right uk-link uk-link-muted" href="login.jsp">去登录</a>
            </div>
        </form>
    </div>
</div>
</body>
</html>

<%
    // 用完session就删掉
    session.removeAttribute("feedback");
%>
