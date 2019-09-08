<%@ page import="com.lingsh.dao.UserDao" %>
<%@ page import="com.lingsh.dao.UserDaoImpl" %>
<%@ page import="com.lingsh.bean.User" %>
<%@ page import="com.lingsh.dao.AdminUserDaoImpl" %><%--
  Created by IntelliJ IDEA.
  User: lingsh
  Date: 19-9-5
  Time: 上午11:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String account = request.getParameter("account");
    String name = request.getParameter("name");

    String auth = request.getParameter("auth");
    System.out.println("Do Forget: auth " + auth);
    if (auth == null) {
        response.sendRedirect("../error.jsp");
        return;
    }
    session.setAttribute("auth", auth);

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
    if (user != null) {
        session.setAttribute("feedback", "");
        if (user.getName().equals(name.trim())) {
            session.setAttribute("feedback", user.getPassword());
        } else {
            session.setAttribute("feedback", "");
        }
    } else {
        session.setAttribute("feedback", "抱歉, 查无此用户");
    }

    response.sendRedirect(String.format("../%s/forget.jsp", auth));
%>
