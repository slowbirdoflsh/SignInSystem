<%--
  Created by IntelliJ IDEA.
  User: lingsh
  Date: 19-9-6
  Time: 下午1:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html class="uk-height-1-1 uk-notouch">
<%
    String auth = request.getParameter("auth");

    if (auth == null || "".equals(auth)) {
        auth = "user";
    }
%>

<head>
    <title>修改密码</title>
    <meta charset="utf-8">
    <link type="text/css" rel="stylesheet" href="styles/uikit-2.25.0/css/uikit.gradient.min.css"/>
    <link type="text/css" rel="stylesheet" href="styles/uikit-2.25.0/css/components/form-password.min.css"/>
    <script src="styles/vendor/jquery.js"></script>
    <script src="styles/uikit-2.25.0/js/uikit.min.js"></script>
    <script src="styles/uikit-2.25.0/js/components/form-password.js"></script>
    <script src="styles/js/validate.js"></script>
    <script src="styles/js/change.js"></script>
</head>
<body class="uk-height-1-1">
<div class="uk-vertical-align uk-text-center uk-height-1-1">
    <div class="uk-vertical-align-middle" style="width: 400px;">
        <form class="uk-panel uk-panel-box uk-form"
              action="action/doChange.jsp?account=${param.account}" method="post" onsubmit="return change()">
            <h2>${param.account}</h2>
            <div class="uk-form-password uk-form-row" style="display: block">
                <label class="uk-form-label uk-text-large uk-float-left">原密码</label>
                <span id="checkPasswordResult" style="color: red" class="uk-float-right"></span>
                <input id="password1" name="orginPassword" class="uk-width-1-1 uk-form-large" type="password"
                       placeholder="原密码" onblur="checkPassword(this.value)">
                <a href="" class="uk-form-password-toggle" data-uk-form-password>Show</a>
            </div>
            <div class="uk-form-password uk-form-row" style="display: block">
                <label class="uk-form-label uk-text-large uk-float-left">新密码</label>
                <span id="checkNewPasswordResult" style="color: red" class="uk-float-right"></span>
                <input id="password" name="newPassword" class="uk-width-1-1 uk-form-large" type="password"
                       placeholder="新密码" onblur="checkNewPassword(this.value)">
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
                <button class="uk-width-1-1 uk-button uk-button-primary uk-button-large" type="submit">修改</button>
                <span id="checkFormResult" style="color: red"></span>
            </div>
            <div class="uk-form-row">
                <span class="uk-float-left" style="color: red">
                    <%=session.getAttribute("change_error") == null ? "" : session.getAttribute("change_error")%>
                </span>
            </div>
            <div class="uk-form-row uk-text-small">
                <a class="uk-float-right uk-link uk-link-muted" href="<%=auth%>/main.jsp">返回主界面</a>
            </div>
        </form>
    </div>
</div>
</body>
</html>
