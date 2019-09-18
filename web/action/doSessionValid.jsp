<%@ page import="com.lingsh.bean.User" %><%--
  Created by IntelliJ IDEA.
  User: lingsh
  Date: 19-9-6
  Time: 下午2:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    User loginUser = (User) session.getAttribute("curUser");
    String auth = (String) session.getAttribute("auth");
    System.out.println("valid: " + auth);
    if (auth == null || "null".equals(auth)) {
        response.sendRedirect("../error.jsp");
        return;
    }

    if (loginUser == null) {
        out.println(String.format("请先<a href='../%s/login.jsp'>登录</a>", session.getAttribute("auth")));
        return;
    }

    /*
    通过登录后session存储用户信息来作为判断依据
    要使用该功能需要在开头加入
     include file="action/doSessionValid.jsp"
    每次使用都需要加入 十分麻烦
    后期可以使用拦截器代替!
     */

%>
