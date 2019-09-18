<%@ page import="com.lingsh.bean.User" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.lingsh.dao.SignDao" %>
<%@ page import="com.lingsh.dao.SignDaoImpl" %>
<%@ page import="com.lingsh.bean.Sign" %>
<%@ page import="java.util.Date" %>
<%--
  Created by IntelliJ IDEA.
  User: lingsh
  Date: 19-9-6
  Time: 上午11:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    User curUser = (User) session.getAttribute("curUser");
    String auth = (String) session.getAttribute("auth");
    System.out.println("-----------签到--------------");
    System.out.println("当前用户: " + curUser);
    System.out.println("当前身份: " + auth);

    SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yy-MM-dd HH:mm:ss");
    SignDao dao = new SignDaoImpl();
    boolean success = dao.addSign(new Sign(curUser.getId(), simpleDateFormat.format(new Date())));

    if (success) {
        out.println("签到成功");
    } else {
        out.println("签到失败");
    }
%>
是否跳转到<a href="../<%=auth%>/main.jsp?table=recorder">主界面</a>