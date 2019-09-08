<%--
  Created by IntelliJ IDEA.
  User: lingsh
  Date: 19-9-3
  Time: 上午9:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html class="uk-height-1-1 uk-notouch">
<head>
    <title>用户登录</title>
    <meta charset="utf-8">
    <link type="text/css" rel="stylesheet" href="../styles/uikit-2.25.0/css/uikit.gradient.min.css"/>
    <link type="text/css" rel="stylesheet" href="../styles/uikit-2.25.0/css/components/form-password.min.css"/>
    <script src="../styles/vendor/jquery.js"></script>
    <script src="../styles/uikit-2.25.0/js/uikit.min.js"></script>
    <script src="../styles/uikit-2.25.0/js/components/form-password.js"></script>
    <script src="../styles/js/validate.js"></script>
    <script src="../styles/js/login.js"></script>
</head>
<%
    String account = "";
    String password = "";

    Cookie[] cookies = request.getCookies();
    for (Cookie cookie : cookies) {
        if ("account".equals(cookie.getName())) {
            account = cookie.getValue();
        } else if ("password".equals(cookie.getName())) {
            password = cookie.getValue();
        }
    }

    System.out.println("需要的 cookie:" + account + ":" + password);
%>
<body class="uk-height-1-1">
<div class="uk-vertical-align uk-text-center uk-height-1-1">
    <div class="uk-vertical-align-middle" style="width: 250px;">
        <form class="uk-panel uk-panel-box uk-form"
              action="../action/doLogin.jsp" method="post" onsubmit="return login()">
            <h2>欢迎登录</h2>
            <input type="hidden" id="auth" name="auth" value="user"/>
            <div class="uk-form-row">
                <input id="account" name="account" class="uk-width-1-1 uk-form-large"
                       value="<%=account%>" type="text" placeholder="账号"
                       onblur="checkAccount(this.value)">
            </div>
            <div class="uk-form-row">
                <span id="checkAccountResult" style="color: red" class="uk-float-right"></span>
            </div>
            <div class="uk-form-row uk-form-password">
                <input id="password" name="password" class="uk-width-1-1 uk-form-large"
                       value="<%=password%>" type="password" placeholder="密码"
                       onblur="checkPassword(this.value)">
                <a href="" class="uk-form-password-toggle" data-uk-form-password>Show</a>
            </div>
            <div class="uk-form-row">
                <span id="checkPasswordResult" style="color: red" class="uk-float-right"></span>
            </div>
            <div class="uk-form-row">
                <label class="uk-float-right">
                    <input id="rem" name="rem" value="remeber" type="checkbox">
                    记住密码</label>
            </div>
            <div class="uk-form-row">
                <button class="uk-width-1-1 uk-button uk-button-primary uk-button-large"
                        type="submit">登录
                </button>
            </div>
            <div class="uk-form-row uk-text-small">
                <a class="uk-float-left uk-link uk-link-muted" href="signup.jsp">注册</a>
                <a class="uk-float-right uk-link uk-link-muted" href="forget.jsp">忘记密码</a>
            </div>
            <div class="uk-form-row">
                <span class="uk-float-left" style="color: red">
                    <%=session.getAttribute("message") == null ? "" : session.getAttribute("message")%>
                </span>
            </div>
            <div class="uk-form-row uk-text-small">
                <a class="uk-float-right uk-link uk-link-muted" href="../admin/login.jsp">我是管理员</a>
            </div>
        </form>
    </div>
</div>
</body>
</html>

<%
    // 用完session就删掉
    session.removeAttribute("message");
%>