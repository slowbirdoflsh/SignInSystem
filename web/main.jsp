<%--
  Created by IntelliJ IDEA.
  User: lingsh
  Date: 19-9-9
  Time: 上午10:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>主界面</title>
    <link rel="stylesheet" href="styles/uikit-2.25.0/css/uikit.gradient.css">
    <script src="styles/vendor/jquery.js"></script>
    <script src="styles/vendor/jquery.cookie.min.js"></script>
    <script src="styles/js/validate.js"></script>
    <script>
        <%-- 在页面加载的运行以下js --%>
        $(document).ready(
            function () {
                // ajax 判断是否登录
                are_you_login();
                // 初始化 整个页面的一些元素
                initElements();
            }
        )
    </script>
    <script src="styles/uikit-2.25.0/js/uikit.min.js"></script>
    <script src="styles/js/main.js"></script>
    <script src="styles/js/ajax.js"></script>
</head>
<body>
<div class="uk-margin">
    <%-- 主界面 导航栏 --%>
    <nav class="uk-navbar">
        <div class="uk-navbar-content">
            <button class="uk-button" data-uk-offcanvas="{target:'#offcanvas-3'}">菜单</button>
        </div>
        <div class="uk-navbar-content"><a id="new_build" href="" onclick="new_build()">新建</a></div>
        <div class="uk-navbar-content uk-hidden-small">
            <div class="uk-form uk-margin-remove uk-display-inline-block">
                <input id="search" name="search" type="text" placeholder="">
                <button id="search_btn" class="uk-button uk-button-primary" onclick="return search()">搜索</button>
            </div>
        </div>
        <div class="uk-navbar-content uk-margin-large-left">
            <label id="welcome" class="uk-text-bold"> test </label>
        </div>
        <div class="uk-navbar-content uk-navbar-flip  uk-hidden-small">
            <div class="uk-button-group">
                <a id="sign_btn" class="uk-button uk-button-danger" href="" onclick="return register()">签到</a>
                <a id="change_pwd" class="uk-button uk-button-danger" href="change.jsp">修改密码</a>
                <a id="logout" class="uk-button uk-button-danger" onclick="logout()">注销</a>
            </div>
        </div>
    </nav>
</div>
<div id="offcanvas-3" class="uk-offcanvas" aria-hidden="true">
    <%-- 侧边导航栏 --%>
    <div class="uk-offcanvas-bar">
        <ul class="uk-nav uk-nav-offcanvas uk-nav-parent-icon" data-uk-nav="">
            <li><h3 id="op_name" class="uk-text-large">管理员操作</h3></li>
            <li id="canvas01" class="uk-active"><a href="" onclick="return mainTableUsers()">用户管理</a></li>
            <li id="canvas02"><a href="" onclick="return mainTableSign()">签到情况</a></li>
        </ul>
    </div>
</div>
<div class="uk-container uk-container-center">
    <%-- 主要内容显示 表格 --%>
    <div class="uk-overflow-container">
        <label>
            <input id="cur_table" type="text" value="users" hidden/>
        </label>
        <table id="display-tbl" class="uk-table uk-table-hover">
            <thead id="thead"></thead>
            <tbody id="tbody"></tbody>
        </table>
        <div id="dialog" class="uk-modal" aria-hidden="true" style="display: none; overflow-y: auto;">
            <div class="uk-modal-dialog">
                <a href="" class="uk-modal-close uk-close"></a>
                <div class="uk-modal-header">
                    <h2 id="dialog-header">修改该用户</h2>
                </div>
                <form class="uk-panel uk-panel-box uk-form" action="main.jsp" method="post">
                    <div class="uk-form-row">
                        <label id="label-0" class="uk-form-label uk-text-large uk-float-left">编号</label>
                        <input id="dialog-0" name="account" class="uk-width-1-1 uk-form-large" type="text" readonly/>
                    </div>
                    <div class="uk-form-row">
                        <label id="label-1" class="uk-form-label uk-text-large uk-float-left">账号</label>
                        <input id="dialog-1" name="account" class="uk-width-1-1 uk-form-large" type="text"/>
                    </div>
                    <div class="uk-form-row" style="display: block">
                        <label id="label-2" class="uk-form-label uk-text-large uk-float-left">密码</label>
                        <input id="dialog-2" name="password" class="uk-width-1-1 uk-form-large" type="text">
                    </div>
                    <div class="uk-form-row">
                        <label id="label-3" class="uk-form-label uk-text-large uk-float-left">姓名</label>
                        <input id="dialog-3" name="name" class="uk-width-1-1 uk-form-large" type="text">
                    </div>
                </form>
                <div class="uk-modal-footer uk-text-right">
                    <button type="button" class="uk-button uk-modal-close">Cancel</button>
                    <button type="button" class="uk-button uk-button-primary" onclick="updateChange()">Save</button>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>