<%@ page import="com.lingsh.bean.User" %>
<%@ page import="com.lingsh.dao.SignDao" %>
<%@ page import="com.lingsh.dao.SignDaoImpl" %>
<%@ page import="com.lingsh.dao.UserDao" %>
<%@ page import="com.lingsh.dao.UserDaoImpl" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%--
  Created by IntelliJ IDEA.
  User: lingsh
  Date: 19-9-5
  Time: 下午9:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String table = request.getParameter("table");
    String search = request.getParameter("search");
    String auth = (String) session.getAttribute("auth");
    String curAccount = (String) session.getAttribute("curAccount");

    System.out.println(String.format("\n\n当前 mainTable.jsp\n table:'%s' search: '%s' auth: '%s'", table, search, auth));

    String extTableHeader = "";
    if ("admin".equals(auth)) {
        extTableHeader = "<th>删除</th><th>修改</th>";
    }

    if ("recorder".equals(table)) {

        // 表头
        out.println(String.format("<thead><tr><th>编号</th>" +
                "<th>用户编号</th>" +
                "<th>姓名</th>" +
                "<th>签到日期</th>%s</tr></thead>", extTableHeader));

        // 打印所有记录
        if (search == null || "".equals(search)) {
            SignDao dao = new SignDaoImpl();
            List<Map> maps = dao.queryAllWithName();
            out.println("<tbody>");
            for (Map map : maps) {
                out.println("<tr>");
                out.println(String.format("<td>%d</td>", (Integer) map.get("id")));
                out.println(String.format("<td>%d</td>", (Integer) map.get("userId")));
                out.println(String.format("<td>%s</td>", (String) map.get("name")));
                out.println(String.format("<td>%s</td>", (String) map.get("signDate")));
                if ("admin".equals(auth)) {

%>
<td>
    <div class="uk-button-group">
        <a class="uk-button uk-button-danger"
           href="../action/doDeleteSign.jsp?signId=<%=map.get("id")%>">删除</a>
    </div>
</td>
<td>
    <div class="uk-button-group">
        <a class="uk-button uk-button-danger"
           href="#">修改</a>
    </div>
</td>
        <%

        }
        out.println("</tr>");
    }
} else {
    // 打印签到表 指定用户姓名记录
    UserDao userDao = new UserDaoImpl();
    List<User> exist = userDao.queryByName(search);
    System.out.println(String.format("查询用户表是否有用户姓名'%s', 结果'%s'", search, exist));
    if (exist != null && exist.size() > 0) {
        SignDao dao = new SignDaoImpl();
        List<Map> maps = dao.queryAllWithNameByName(search);
        out.println("<tbody>");
        for (Map map : maps) {
            out.println("<tr>");
            out.println(String.format("<td>%d</td>", (Integer) map.get("id")));
            out.println(String.format("<td>%d</td>", (Integer) map.get("userId")));
            out.println(String.format("<td>%s</td>", (String) map.get("name")));
            out.println(String.format("<td>%s</td>", (String) map.get("signDate")));
            if ("admin".equals(auth)) {

%>
   <td>
       <div class="uk-button-group">
           <a class="uk-button uk-button-danger"
              href="../action/doDeleteSign.jsp?signId=<%=map.get("id")%>">删除</a>
           </div>
   </td>
    <td>
        <div class="uk-button-group">
            <a class="uk-button uk-button-danger"
               href="#">修改</a>
        </div>
    </td>
<%

                }
                out.println("</tr>");
            }
        } else {
            out.println(String.format("抱歉, 用户姓名为%s 查无记录", search));
        }
    }
    out.println("</tbody>");
} else {

    // 表头
    out.println(String.format("<thead><tr><th>编号</th>" +
            "<th>账号</th>" +
            "<th>密码</th>" +
            "<th>姓名</th>%s</tr></thead>", extTableHeader));

    // 当没有search字段或者该字段为空""
    // 打印所有记录
    if (search == null || "".equals(search)) {
        UserDao dao = new UserDaoImpl();
        List<User> users = dao.queryAllUsers();
        out.println("<tbody>");
        for (User user : users) {
            out.println("<tr>");
            out.println(String.format("<td>%d</td>", user.getId()));
            out.println(String.format("<td>%s</td>", user.getAccount()));
            out.println(String.format("<td>%s</td>", user.getPassword()));
            out.println(String.format("<td>%s</td>", user.getName()));
            if ("admin".equals(auth)) {

%>
<td>
    <div class=" uk-button-group">
        <a class="uk-button uk-button-danger"
           href="../action/doDeleteUser.jsp?account=<%=user.getAccount()%>">删除</a>
    </div>
</td>
<td>
    <div class=" uk-button-group">
        <a class="uk-button uk-button-danger"
           href="../admin/update.jsp?account=<%=user.getAccount()%>">修改</a>
    </div>
</td>
        <%

        }
        out.println("</tr>");
    }
} else {
    // 打印用户表 指定用户账号记录
    UserDao userDao = new UserDaoImpl();
    User user = userDao.queryByAccount(search);
    if (user != null) {
        out.println("<tr>");
        out.println(String.format("<td>%d</td>", user.getId()));
        out.println(String.format("<td>%s</td>", user.getAccount()));
        out.println(String.format("<td>%s</td>", user.getPassword()));
        out.println(String.format("<td>%s</td>", user.getName()));
        if ("admin".equals(auth)) {

%>
        <td>
            <div class="uk-button-group">
                <a class="uk-button uk-button-danger"
                   href="../action/doDeleteUser.jsp?account=<%=user.getAccount()%>">删除</a>
            </div>
        </td>
<td>
            <div class="uk-button-group">
                <a class="uk-button uk-button-danger"
                   href="../admin/update.jsp?account=<%=user.getAccount()%>">修改</a>
            </div>
        </td>
        <%

                }
                out.println("</tr>");
            } else {
                out.println(String.format("抱歉, 用户账号为%s 查无记录", search));
            }
            out.println("</tbody>");
        }
    }
%>
