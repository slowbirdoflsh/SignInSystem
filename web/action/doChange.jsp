<%@ page import="com.lingsh.dao.UserDaoImpl" %>
<%@ page import="com.lingsh.dao.UserDao" %>
<%@ page import="com.lingsh.bean.User" %>
<%@ page import="com.lingsh.dao.AdminUserDaoImpl" %><%--
  Created by IntelliJ IDEA.
  User: lingsh
  Date: 19-9-6
  Time: 下午1:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String account = request.getParameter("account");
    String password = request.getParameter("orginPassword");
    String newPassword = request.getParameter("newPassword");
    String auth = (String) session.getAttribute("auth");
    System.out.println(String.format("auth: %s \nchange : account:%s password: %s --> %s",
            auth, account, password, newPassword));

    UserDao dao = null;
    if ("user".equals(auth)) {
        dao = new UserDaoImpl();
    } else if ("admin".equals(auth)){
        dao = new AdminUserDaoImpl();
    } else {
        response.sendRedirect("../error.jsp");
        return;
    }
    User user = dao.queryByAccount(account);

    boolean success = true;
    if (user.getPassword().equals(password)) {
        user.setPassword(newPassword);
        dao.update(user);

        out.println("修改密码成功");
    } else {
        out.println("输入密码有误");
        session.setAttribute("change_error", "输入密码有误");
        success = false;
    }

    if (success) {
    /* <a href="../$auth/login.jsp">跳转到登录界面</a> */
        out.println(String.format("跳转到<a href='../%s/login.jsp'>登录</a>界面", auth));
    } else {
        /* <a href="../$auth/change.jsp">跳转到修改密码界面</a> */
        out.println(String.format("跳转到<a href='../%s/change.jsp'>修改密码</a>界面", auth));
    }
%>