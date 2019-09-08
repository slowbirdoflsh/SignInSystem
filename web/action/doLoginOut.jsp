<%--
  Created by IntelliJ IDEA.
  User: lingsh
  Date: 19-9-6
  Time: 下午2:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    session.removeAttribute("curUser");
    session.removeAttribute("curAccount");
    response.sendRedirect(String.format("../%s/login.jsp", session.getAttribute("auth")));
%>
