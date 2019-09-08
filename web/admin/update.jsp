<%@ page import="com.lingsh.dao.UserDao" %>
<%@ page import="com.lingsh.dao.UserDaoImpl" %>
<%@ page import="com.lingsh.bean.User" %><%--
  Created by IntelliJ IDEA.

  更新操作 暂时只做了用户修改的功能
  过于重复 需要后期整合好之后 才打算去实现

  User: lingsh
  Date: 19-9-7
  Time: 下午2:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html class="uk-height-1-1 uk-notouch">
<%
    String account = request.getParameter("account");

    UserDao dao = new UserDaoImpl();
    User user = dao.queryByAccount(account);

    String password = user.getPassword();
    String name = user.getName();
%>

<head>
    <title>修改用户</title>
    <meta charset="utf-8">
    <link type="text/css" rel="stylesheet" href="../styles/uikit-2.25.0/css/uikit.gradient.min.css"/>
    <script src="../styles/vendor/jquery.js"></script>
    <script src="../styles/uikit-2.25.0/js/uikit.min.js"></script>
    <script src="../styles/js/validate.js"></script>
</head>
<body class="uk-height-1-1">
<div class="uk-vertical-align uk-text-center uk-height-1-1">
    <div class="uk-vertical-align-middle" style="width: 450px;">
        <form class="uk-panel uk-panel-box uk-form" action="../action/doUpdateUser.jsp" method="post">
            <h2>注册新用户</h2>
            <input type="hidden" id="auth" name="auth" value="admin"/>
            <div class="uk-form-row">
                <label class="uk-form-label uk-text-large uk-float-left">账号</label>
                <span id="checkAccountResult" style="color: red" class="uk-float-right"></span>
                <input id="account" name="account" class="uk-width-1-1 uk-form-large" type="text"
                       value="<%=account%>" readonly/>
            </div>
            <div class="uk-form-row" style="display: block">
                <label class="uk-form-label uk-text-large uk-float-left">密码</label>
                <span id="checkPasswordResult" style="color: red" class="uk-float-right"></span>
                <input id="password" name="password" class="uk-width-1-1 uk-form-large" type="text"
                       value="<%=password%>"
                       placeholder="登录密码, 不少于6个字符" onblur="checkPassword(this.value)">
            </div>
            <div class="uk-form-row">
                <label class="uk-form-label uk-text-large uk-float-left">姓名</label>
                <span id="checkNameResult" style="color: red" class="uk-float-right"></span>
                <input id="name" name="name" class="uk-width-1-1 uk-form-large" type="text"
                       value="<%=name%>"
                       placeholder="用户昵称, 不少于6个字符" onblur="checkName(this.value)">
            </div>
            <div class="uk-form-row">
                <button class="uk-width-1-1 uk-button uk-button-primary uk-button-large" type="submit">修改</button>
                <span id="checkFormResult" style="color: red"></span>
            </div>
            <div class="uk-form-row">
                <span class="uk-float-left" style="color: red">
                    <%=session.getAttribute("error") == null ? "" : session.getAttribute("error")%>
                </span>
            </div>
            <div class="uk-form-row uk-text-small">
                <a class="uk-float-right uk-link uk-link-muted" href="main.jsp">返回主界面</a>
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