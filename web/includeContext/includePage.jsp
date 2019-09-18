<%@ page import="com.lingsh.bean.User" %>
<%@ page import="java.util.List" %>
<%@ page import="com.lingsh.dao.UserDaoImpl" %>
<%@ page import="com.lingsh.dao.UserDao" %>
<%--
  Created by IntelliJ IDEA.
  User: lingsh
  Date: 19-9-5
  Time: 下午8:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    UserDao userDao = new UserDaoImpl();
    List<User> users = userDao.queryAllUsers();

    for (User user : users) {
        out.println("<tr>");
        out.println(String.format("<td> %d </td> " +
                        "<td>  %s </td> " +
                        "<td>  %s </td> " +
                        "<td>  %s </td>",
                user.getId(), user.getAccount(), user.getPassword(), user.getName()));
        out.println("<td> <button> 更改/删除 </button> </td>");
        out.println("</tr>");
    }
%>
