<%@ page import="com.lingsh.dao.UserDaoImpl" %>
<%@ page import="com.lingsh.dao.UserDao" %>
<%@ page import="com.lingsh.bean.User" %><%--
  Created by IntelliJ IDEA.
  User: lingsh
  Date: 19-9-7
  Time: 下午2:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String account = request.getParameter("account");
    String password = request.getParameter("password");
    String name = request.getParameter("name");

    UserDao dao = new UserDaoImpl();
    User user = dao.queryByAccount(account);
    System.out.println("\n\n用户更新: " + user);

    user.setPassword(password);
    user.setName(name);
    System.out.println(user);

    boolean success = dao.update(user);
    if (success) {
        out.println(String.format("成功修改用户%s", account));
    } else {
        out.println(String.format("修改用户%s失败", account));
    }
%>
返回<a href='../admin/main.jsp?table=user'>主界面</a>
