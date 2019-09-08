<%@ page import="com.lingsh.dao.UserDao" %>
<%@ page import="com.lingsh.dao.UserDaoImpl" %>
<%@ page import="com.lingsh.bean.User" %>
<%@ page import="com.lingsh.bean.Sign" %>
<%@ page import="com.lingsh.dao.SignDao" %>
<%@ page import="com.lingsh.dao.SignDaoImpl" %><%--
  Created by IntelliJ IDEA.
  User: lingsh
  Date: 19-9-7
  Time: 下午1:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String account = request.getParameter("account");
    String signDate = request.getParameter("signDate");
    String auth = (String) session.getAttribute("auth");

    UserDao userDao = new UserDaoImpl();
    User user = userDao.queryByAccount(account);

    if (user == null) {
        out.println("添加签到记录失败 用户不存在, 返回<a href='doNewCreate.jsp?table=recorder'>添加界面</a>");
    } else {
        Sign sign = new Sign(user.getId(), signDate);
        SignDao dao = new SignDaoImpl();
        boolean success = dao.addSign(sign);
        if (success) {
            System.out.println("添加 记录: " + sign);
            out.println(String.format("添加签到记录成功, 可以返回<a href='../%s/main.jsp?table=recorder'>主界面</a>查看", auth));
        } else {
            out.println(String.format("添加签到记录失败, 返回<a href='../%s/main.jsp?table=recorder'>主界面</a>", auth));

        }
    }
%>