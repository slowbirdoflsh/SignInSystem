<%@ page import="com.lingsh.dao.UserDao" %>
<%@ page import="com.lingsh.dao.UserDaoImpl" %>
<%@ page import="com.lingsh.bean.User" %><%--
  Created by IntelliJ IDEA.
  User: lingsh
  Date: 19-9-7
  Time: 下午1:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String account = request.getParameter("account");
    String password = request.getParameter("password");
    String name = request.getParameter("name");
    String auth = (String) session.getAttribute("auth");

    UserDao dao = new UserDaoImpl();

    boolean existed = dao.queryByAccount(account) == null;
    if (existed) {
        User user = new User(null, account, password, name);
        dao.addUser(user);
        System.out.println("添加" + user);
        out.println(String.format("添加用户成功, 可以返回<a href='../%s/main.jsp'>主界面</a>查看", auth));
    } else {
        System.out.println("抱歉, 该账号已存在");
        session.setAttribute("error", "抱歉, 该账号已存在");
        response.sendRedirect(String.format("../%s/main.jsp", auth));
    }
%>
