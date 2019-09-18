<%--
  Created by IntelliJ IDEA.
  User: lingsh
  Date: 19-9-7
  Time: 下午1:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String table = request.getParameter("table");

    if ("recorder".equals(table)) {
%>
<%-- 注意此处不兼容中文 TODO --%>
<jsp:include page="../includeContext/includeCreateSign.jsp">
    <jsp:param name="title" value="create new sign"/>
</jsp:include>
<%
    } else {
        %>
<%-- 注意此处不兼容中文 TODO --%>
<jsp:include page="../includeContext/includeCreateUser.jsp">
    <jsp:param name="title" value="create new user"/>
</jsp:include>
<%
    }
%>



