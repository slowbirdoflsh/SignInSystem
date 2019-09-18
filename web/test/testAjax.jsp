<%--
  Created by IntelliJ IDEA.
  User: lingsh
  Date: 19-9-9
  Time: 下午11:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Ajax Test</title>
    <script type="text/javascript" src="../styles/vendor/jquery.js"></script>
</head>
<body>
<div>
    <label>
        username:
        <input type="text" id="username" name="username"/>
    </label>
    <br>
    <label>
        password:
        <input type="text" id="password" name="password"/>
    </label>
</div>
<div>
    <label>
        点击使用GET方式连接服务器
        <button id="btn_get" onclick="getAjaxServlet()">GET</button>
    </label>
    <script>
        function getAjaxServlet() {
            var xhr = null;
            // 获得传输参数 username password
            var username = document.getElementById("username").value;
            var password = document.getElementById("password").value;
            var url = "AjaxServlet";
            var data = {username: username, password: password};

            $.ajax({
                type: 'get',
                dataType: 'text',
                url: url,
                data: data,
                success: function (msg) {
                    alert("servlet --> ajax (by get)");
                    console.log(msg);
                    document.getElementById("txt").innerHTML = msg;
                },
                error: function (msg) {
                    console.log(msg);
                }
            })
        }
    </script>
    <br>
    <label>
        点击使用POST方式连接服务器
        <button id="btn_post" onclick="postAjaxServlet()">POST</button>
    </label>
    <script>
        function postAjaxServlet() {
            var username = document.getElementById("username").value;
            var password = document.getElementById("password").value;
            var url = "AjaxServlet";
            var user = {username: username, password: password};

            $.ajax({
                    type: "post",
                    // 预期服务器返回的值 这里需要和后台同一 否则会无法识别
                    dataType: "html",
                    url: url,
                    data: user,
                    success: function (msg) {
                        alert("servlet --> ajax (by post)");
                        console.log(msg);
                        document.getElementById("txt").innerHTML = msg;
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        console.log(XMLHttpRequest);
                        console.log(textStatus);
                        console.log(errorThrown);
                    }
                }
            )
        }
    </script>
</div>
<div>
    <label id="txt" style="color: red">
        <%-- 设置 返回内容在此处显示 (color:red 表示标红 醒目) --%>
    </label>
</div>
</body>
</html>
