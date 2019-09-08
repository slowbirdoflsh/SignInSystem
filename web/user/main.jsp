<%--
  Created by IntelliJ IDEA.
  User: lingsh
  Date: 19-9-3
  Time: 上午11:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../action/doSessionValid.jsp" %>
<html>
<%
    String curTable = request.getParameter("table");
    String curSearch = request.getParameter("search");
    String curAccount = (String) session.getAttribute("curAccount");

    if (curTable == null || "".equals(curTable) || "null".equals(curTable)) {
        curTable = "user";
    }

    // 控制搜索输入框背景显示 不同的搜索使用不同的提示语 (也是为了引导正确输入参数)
    String searchContent = "recorder".equals(curTable) ? "搜索签到表用户姓名" : "搜索用户表用户账号";

    System.out.println(String.format("curTable : '%s', curSearch : '%s'", curTable, curSearch));
%>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>主界面</title>
    <link rel="stylesheet" href="../styles/uikit-2.25.0/css/uikit.gradient.css">
    <script src="../styles/vendor/jquery.js"></script>
    <script src="../styles/uikit-2.25.0/js/uikit.js"></script>
</head>
<body>
<div class="uk-margin">
    <nav class="uk-navbar">
        <div class="uk-navbar-content">
            <button class="uk-button" data-uk-offcanvas="{target:'#offcanvas-3'}">菜单</button>
        </div>
        <div class="uk-navbar-content uk-hidden-small">
            <form class="uk-form uk-margin-remove uk-display-inline-block"
                  action="main.jsp?table=<%=curTable%>&search=<%=curSearch%>"
                  method="get">
                <input type="hidden" name="table" value="<%=curTable%>">
                <input id="search" name="search" type="text"
                       placeholder="<%=searchContent%>">
                <button class="uk-button uk-button-primary">搜索</button>
            </form>
        </div>
        <div class="uk-navbar-content uk-margin-large-left">
            欢迎用户 <label class="uk-text-bold"><%=curAccount%>
        </label> 登录
        </div>
        <div class="uk-navbar-content uk-navbar-flip  uk-hidden-small">
            <div class="uk-button-group">
                <a class="uk-button uk-button-danger" href="../action/doRecorder.jsp">签到</a>
                <a class="uk-button uk-button-danger"
                   href="../change.jsp?account=<%=curAccount%>&auth=<%=auth%>">修改密码</a>
                <a class="uk-button uk-button-danger" href="../action/doLoginOut.jsp">注销</a>
            </div>
        </div>
    </nav>
</div>
<div id="offcanvas-3" class="uk-offcanvas" aria-hidden="true">
    <div class="uk-offcanvas-bar">
        <ul class="uk-nav uk-nav-offcanvas uk-nav-parent-icon" data-uk-nav="">
            <li>
                <h3 class="uk-text-large">用户操作</h3>
            </li>
            <li id="canvas02" class="uk-active">
                <a href="main.jsp?table=recorder">签到情况</a>
            </li>
        </ul>
    </div>
</div>
<div class="uk-container uk-container-center">
    <div class="uk-overflow-container">
        <table class="uk-table uk-table-hover">
            <%-- 通过URL的参数来控制显示的表格内容 --%>
            <jsp:include page="../includeContext/includeMainTable.jsp">
                <jsp:param name="table" value="recorder"/>
                <jsp:param name="search" value="${param.search}"/>
            </jsp:include>
        </table>
    </div>
</div>
</body>
</html>