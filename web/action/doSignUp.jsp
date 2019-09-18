<%@ page import="com.lingsh.bean.User" %>
<%@ page import="com.lingsh.dao.UserDao" %>
<%@ page import="com.lingsh.dao.UserDaoImpl" %>
<%@ page import="com.lingsh.dao.AdminUserDaoImpl" %><%--
  Created by IntelliJ IDEA.
  User: lingsh
  Date: 19-9-4
  Time: 上午10:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String account = request.getParameter("account");
    String password = request.getParameter("password");
    String name = request.getParameter("name");
    String auth = request.getParameter("auth");

    System.out.println(String.format("来自注册界面 %s %s %s %s", account, password, name, auth));

    // 对传入前台的报错信息error清空
    session.setAttribute("error", "");

    UserDao dao = null;
    if ("user".equals(auth)) {
        dao = new UserDaoImpl();
    } else if ("admin".equals(auth)){
        dao = new AdminUserDaoImpl();
    } else {
        return;
    }
    boolean existed = dao.queryByAccount(account) == null;
    if (existed) {
        User user = new User(null, account, password, name);
        dao.addUser(user);
        System.out.println("添加" + user);
        out.println(String.format("注册成功, 请先返回<a href='../%s/login.jsp'>登录</a>", auth));
    } else {
        System.out.println("抱歉, 该账号已存在");
        session.setAttribute("error", "抱歉, 该账号已存在");
        response.sendRedirect(String.format("../%s/signup.jsp", auth));
    }
%>
