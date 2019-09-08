<%@ page import="com.lingsh.dao.SignDao" %>
<%@ page import="com.lingsh.dao.SignDaoImpl" %>
<%--
  Created by IntelliJ IDEA.
  User: lingsh
  Date: 19-9-7
  Time: 下午12:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Integer id = Integer.valueOf(request.getParameter("signId"));

    SignDao dao = new SignDaoImpl();
    boolean success = dao.deleteSignById(id);
    if (success) {
        out.println(String.format("成功删除编号%d的记录", id));
    } else {
        out.println(String.format("删除编号%d的记录失败", id));
    }
%>
<a href='../admin/main.jsp?table=recorder'>返回主界面</a>