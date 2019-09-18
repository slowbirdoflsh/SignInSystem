[JavaEE 入门]使用ajax与Servlet进行简单的GET/POST交换信息

[toc]

## ajax 介绍
ajax:前端与后台交换信息的一种方式
## 编程环境
系统: Deepin 15.9.2 桌面版  
JDK: 1.8  
Tomcat: 9.0.14  
IDE: IntelliJ IDEA 2018  
Chrome: 70.0.3538.77 (正式版本) （64 位）
## 实例 原生js
### 后台-Servlet代码
Servlet代码如下:
```java
package com.lingsh.servlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * 使用Ajax与Servlet交换信息
 *
 * @author lingsh
 * @version 1.0
 * @date 19-9-9 下午10:58
 */

public class AjaxServlet extends HttpServlet {

    public AjaxServlet() {

    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setCharacterEncoding("utf-8");
        req.setCharacterEncoding("utf-8");

        System.out.println("ajax --> servlet (by get)");

        login(req, resp, "GET:\t");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setCharacterEncoding("utf-8");
        req.setCharacterEncoding("utf-8");

        System.out.println("ajax --> servlet (by post)");

        login(req, resp, "POST:\t");
    }

    private void login(HttpServletRequest req, HttpServletResponse resp, String label) throws IOException {
        // 获得客户端发来的username和password数据
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        // 获得参数后, 生成响应内容
        String content = String.format("%s username: %s\tpassword: %s", label, username, password);
        System.out.println(content);

        // 设置响应类型
        resp.setContentType("text/html;charset=utf-8");
        // 将数据传入前台
        PrintWriter writer = resp.getWriter();
        writer.println(content);
        writer.flush();
    }
}
```
#### web.xml配置
web.xml的servlet配置:
```xml
<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns="http://xmlns.jcp.org/xml/ns/javaee"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/javaee http://xmlns.jcp.org/xml/ns/javaee/web-app_4_0.xsd"
         version="4.0">
    <!-- 声明servlet -->
    <servlet>
        <!-- servlet别名 -->
        <servlet-name>AjaxServlet</servlet-name>
        <!-- 该servlet所在类 -->
        <servlet-class>com.lingsh.servlet.AjaxServlet</servlet-class>
    </servlet>

    <servlet-mapping>
        <!-- 指定Servlet 使用所声明的Servlet别名 -->
        <servlet-name>AjaxServlet</servlet-name>
        <!-- 拦截方式 localhost:8080/test/AjaxServlet 可以访问到 -->
        <!-- 配置好的效果应该是 可以直接在游览器上访问(GET) 没有报错! -->
        <url-pattern>/test/AjaxServlet</url-pattern>
    </servlet-mapping>
</web-app>
```
### 前端-jsp(html+js)代码
html和js的代码(jsp)如下:
```html
<html>
<head>
    <title>Ajax Test</title>
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
            
            // GET 方式url 参数是裸露在地址上的
            // 直接使用AjaxServlet是因为当前页面为'localhost:8080/test/testAjax.jsp'
            // 在传输时 AjaxServlet --> 'localhost:8080/test/AjaxServlet'
            // 这个可以从游览器中的检查元素的'Network' 抓包看到
            var url = "AjaxServlet?username=" + username + "&password=" + password;

            // 获取XMLHttpRequest
            if (window.XMLHttpRequest) {
                xhr = new XMLHttpRequest();
            } else if (window.ActiveXObject) {
                xhr = new ActiveXObject("Microsoft.XMLHTTP");
            } else {
                alert("sorry, the version of your explorer is not support ajax!")
            }

            // 绑定回调方法
            // 监听readyState参数 每次该参数改变都会调用该方法
            xhr.onreadystatechange = function () {
                // readyState参数
                /*
                    0: 请求 未初始化(还没有调用open())
                    1: 请求 已经建立, 但是还没有发送(还没有调用send())
                    2: 请求 已经发送, 正在处理中 (通常现在可以从响应中获取内容头)
                    3: 请求 在处理中, 通常响应中已有部分数据可用了, 但服务器还没有完成响应的生成
                    4: 响应 已经完成, 可以获取并使用服务器的响应了
                 */
                if (xhr.readyState === 4) {
                    // status
                    // 200 表示服务器响应成功
                    // 404 表示未获取到资源
                    // 500 服务器内部错误
                    if (xhr.status === 200) {
                        alert("servlet --> ajax (by get)");
                        document.getElementById("txt").innerHTML = xhr.responseText;
                    }
                }
            };

            // open(传输方式, 传输的目标地址, 调用send()后是否可以异步操作)
            // 异步操作 不必一直等待响应 可以在响应之前执行其他js任务
            xhr.open("GET", url, true);
            xhr.send();
        }
    </script>
    <br>
    <label>
        点击使用POST方式连接服务器
        <button id="btn_post" onclick="postAjaxServlet()">POST</button>
    </label>
    <script>
        function postAjaxServlet() {
            var xhr = null;
            var username = document.getElementById("username").value;
            var password = document.getElementById("password").value;
            var url = "AjaxServlet";

            if (window.XMLHttpRequest) {
                xhr = new XMLHttpRequest();
            } else if (window.ActiveXObject) {
                xhr = new ActiveXObject("Microsoft.XMLHTTP");
            } else {
                alert("sorry, the version of your explorer is not support ajax!")
            }

            xhr.onreadystatechange = function () {
                if (xhr.readyState === 4) {
                    if (xhr.status === 200) {
                        alert("servlet --> ajax (by post)");
                        document.getElementById("txt").innerHTML = xhr.responseText;
                    }
                }
            };

            xhr.open("POST", url, true);
            // 设置请求头(必须) 不然servlet收不到参数!
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=UTF-8");
            // 通过send的方式传输参数
            xhr.send("username=" + username + "&password=" + password);
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
```

### 实例的文件系统路径
AjaxServlet.java: src/com/lingsh/servlet/AjaxServlet.java
testAjax.jsp: web/test/testAjax.jsp

![image](/home/lingsh/Article/2019_08/project/SignInSystem/StudentSignInSystem/notes/img/ajax/files-path.png)

### 运行结果展示
ajax通过get方式传输参数给Servlet  
获得响应打印到网页
![image](/home/lingsh/Article/2019_08/project/SignInSystem/StudentSignInSystem/notes/img/ajax/result-get.png)

ajax通过post方式传输参数给Servlet  
获得响应打印到网页
![image](/home/lingsh/Article/2019_08/project/SignInSystem/StudentSignInSystem/notes/img/ajax/result-post.png)

ajax通过get方式传输参数给Servlet  
F12抓包可以看出参数被裸露在url上
![image](/home/lingsh/Article/2019_08/project/SignInSystem/StudentSignInSystem/notes/img/ajax/pure-ajax-get.png)



```js
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
```

### 遭遇问题
#### Servlet找不到 404
1. 没有在web.xml设置映射
2. url-pattern设置有问题 这个多尝试几遍就可以确定文件设置路径
#### ajax 连接不了Servlet
1. 个人是因为Tomcat缓存(热加载)问题, 以为自己更新了代码, 其实底层代码还是没有加载上去
2. ajax GET/POST路径有问题 这个通过Chrome F12抓包,查看ajax发送的路径进行调整

## 实例 使用jQuery
### 前端-js代码(节选 --只改变方法)
#### get
```js
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
```

#### post
```js
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
```

#### jquery通过ajax方法获取json数据不执行Success的原因及解决方案
1. dataType是期望服务器返回的数据, 本实例下Servlet返回的是文本(html/text)
2. 可以使用error参数, 将错误信息捕捉并打印出来
