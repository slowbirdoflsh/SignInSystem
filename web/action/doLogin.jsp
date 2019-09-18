<%@ page import="com.lingsh.bean.User" %>
<%@ page import="com.lingsh.dao.UserDao" %>
<%@ page import="com.lingsh.dao.UserDaoImpl" %>
<%@ page import="com.lingsh.dao.AdminUserDaoImpl" %>
<%--
  Created by IntelliJ IDEA.
  User: lingsh
  Date: 19-9-3
  Time: 上午10:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // 接收表单传过来的值
    String account = request.getParameter("account");
    String password = request.getParameter("password");
    String auth = request.getParameter("auth");

    System.out.println(String.format("HTML输入 账号: %s 密码: %s 权限: %s", account, password, auth));

    session.setAttribute("message", "");

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

    User users = dao.queryByAccount(account.trim());

    if (users.getPassword().equals(password)) {
        // 将用户信息保存到session对象 所有页面共享一个session
        session.setAttribute("curUser", users);
        session.setAttribute("curAccount", users.getAccount());

        // 使用Cookie保存密码
        String rem = request.getParameter("rem");
        Cookie accountCookie = new Cookie("account", account);
        Cookie passwordCookie = new Cookie("password", password);
        int expiry = rem != null ? 7 * 24 * 60 * 60 : 0;
        System.out.println("获取rem:" + rem + ", expiry: " + expiry);

        // ! 如果需要使用cookie的页面不与当前页面同一目录下 需要设置path值 否则目录外的页面获取不到
        accountCookie.setPath("/");
        passwordCookie.setPath("/");

        accountCookie.setMaxAge(expiry);
        passwordCookie.setMaxAge(expiry);

        response.addCookie(accountCookie);
        response.addCookie(passwordCookie);

        response.sendRedirect(String.format("../%s/main.jsp", auth));
    } else {
        session.setAttribute("message", "抱歉, 你输入的账号或密码错误!");
        response.sendRedirect(String.format("../%s/login.jsp", auth));
    }
%>