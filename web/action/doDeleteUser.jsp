<%@ page import="com.lingsh.dao.UserDao" %>
<%@ page import="com.lingsh.dao.UserDaoImpl" %><%--
  Created by IntelliJ IDEA.
  User: lingsh
  Date: 19-9-7
  Time: 下午12:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String account = request.getParameter("account");

    UserDao dao = new UserDaoImpl();
    boolean success = dao.deleteByAccount(account);
    if (success) {
        out.println(String.format("成功删除用户%s", account));
    } else {
        out.println(String.format("删除用户%s失败", account));
    }
%>
<a href='../admin/main.jsp?table=user'>返回主界面</a>
