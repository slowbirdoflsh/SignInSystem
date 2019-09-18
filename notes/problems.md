[JavaWeb 初步]前端与后台 Ajax工作方式(异步/同步)问题

> 前端发起的POST 并没有等待后台的返回就进行了下一步操作  
> 经过排查,初步认为是ajax异步问题    
> 没有等到程序处理数据返回结果, 就进行了其他操作

### 问题背景
- 简单的用户登录, 先将用户存入cookie, 再发送请求给Servlet, Servlet处理数据返回结果,并将成功登录的用户存入列表(静态), 如果返回结果为"success"则跳转页面到主页面  
- 主页面有一个预处理js, 验证当前cookie所存用户是否登录, 也会发送请求给Servlet, 直接查询登录列表, 如果在列表里, 这表示cookie所存储用户已登录    

#### 现象
用户登录, 跳转在主页面, 主页面验证认为没有登录

### 问题定位
#### 1. 首先查看日志
发现login还未完全执行完, 就执行valid验证去了  
正常的操作应该是:(login.jsp)login -->(success) --> (main.jsp)valid --> (success)  
现在的情况是: (login.jsp)login --> ...  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  (main.jsp)valid --> ...   
```text
16:26:32.942 [http-nio-8080-exec-1] INFO  com.lingsh.servlet.AjaxServlet - ajax --> servlet (by post)
16:26:32.945 [http-nio-8080-exec-1] INFO  com.lingsh.servlet.AjaxServlet - POST 前端传入的参数: {"password":"123456","method":"login","auth":"user","account":"admin","timestamp":"1568535992934"} 
16:26:32.946 [http-nio-8080-exec-1] INFO  com.lingsh.service.UserService - login	 登录前 先查看所有已登录用户 {}
16:26:32.952 [http-nio-8080-exec-1] INFO  com.lingsh.service.UserService - login	 前端传入参数列表 {password=123456, method=login, auth=user, account=admin, timestamp=1568535992934}
Query By Account:select * from users where account=?

16:26:33.353 [http-nio-8080-exec-7] INFO  com.lingsh.servlet.AjaxServlet - ajax --> servlet (by post)
16:26:33.355 [http-nio-8080-exec-7] INFO  com.lingsh.servlet.AjaxServlet - POST 前端传入的参数: {"method":"valid","id":"user#admin#1568535992934#"} 
16:26:33.361 [http-nio-8080-exec-7] INFO  com.lingsh.service.UserService - valid	 {"method":"valid","id":"user#admin#1568535992934#"}

16:26:33.362 [http-nio-8080-exec-6] INFO  com.lingsh.servlet.AjaxServlet - ajax --> servlet (by post)
16:26:33.362 [http-nio-8080-exec-7] INFO  com.lingsh.service.UserService - valid	 get id: user#admin#1568535992934#
all users: {}
16:26:33.366 [http-nio-8080-exec-6] INFO  com.lingsh.servlet.AjaxServlet - POST 前端传入的参数: {"method":"getData","content":"users"} 
16:26:33.367 [http-nio-8080-exec-6] INFO  com.lingsh.service.UserService - getData	 json: {"method":"getData","content":"users"}
16:26:33.367 [http-nio-8080-exec-7] INFO  com.lingsh.servlet.AjaxServlet - 后台传出的消息: {"ret":"failed","msg":"抱歉, 你还未登录,请先登录!"} 1568535993367

16:26:34.007 [http-nio-8080-exec-1] INFO  com.lingsh.service.UserService - login	 数据库查询到的用户 user:User {id=1, account='admin', password='123456', name='lingsh1'}
16:26:34.008 [http-nio-8080-exec-1] INFO  com.lingsh.service.UserService - login	 当前登录列表 users: {user#admin#1568535992934#=User {id=1, account='admin', password='123456', name='lingsh1'}}
16:26:34.009 [http-nio-8080-exec-1] INFO  com.lingsh.servlet.AjaxServlet - 后台传出的消息: {"ret":"success","msg":""} 1568535994009
16:26:34.014 [http-nio-8080-exec-6] INFO  com.lingsh.service.UserService - getUsersJson	 result: ***
16:26:34.016 [http-nio-8080-exec-6] INFO  com.lingsh.servlet.AjaxServlet - 后台传出的消息: {"ret":"success","msg":"***"} 1568535994016

16:26:35.782 [http-nio-8080-exec-10] INFO  com.lingsh.servlet.AjaxServlet - ajax --> servlet (by post)
16:26:35.783 [http-nio-8080-exec-10] INFO  com.lingsh.servlet.AjaxServlet - POST 前端传入的参数: {"method":"valid","id":"user#admin#1568535992934#"} 
16:26:35.784 [http-nio-8080-exec-10] INFO  com.lingsh.service.UserService - valid	 {"method":"valid","id":"user#admin#1568535992934#"}
16:26:35.786 [http-nio-8080-exec-10] INFO  com.lingsh.service.UserService - valid	 get id: user#admin#1568535992934#
all users: {user#admin#1568535992934#=User {id=1, account='admin', password='123456', name='lingsh1'}}
16:26:35.787 [http-nio-8080-exec-10] INFO  com.lingsh.servlet.AjaxServlet - 后台传出的消息: {"ret":"success","msg":""} 1568535995787
16:26:35.912 [http-nio-8080-exec-5] INFO  com.lingsh.servlet.AjaxServlet - ajax --> servlet (by post)
16:26:35.916 [http-nio-8080-exec-5] INFO  com.lingsh.servlet.AjaxServlet - POST 前端传入的参数: {"method":"valid","id":"user#admin#1568535992934#"} 
16:26:35.918 [http-nio-8080-exec-4] INFO  com.lingsh.servlet.AjaxServlet - ajax --> servlet (by post)
16:26:35.919 [http-nio-8080-exec-5] INFO  com.lingsh.service.UserService - valid	 {"method":"valid","id":"user#admin#1568535992934#"}
16:26:35.920 [http-nio-8080-exec-4] INFO  com.lingsh.servlet.AjaxServlet - POST 前端传入的参数: {"method":"getData","content":"users"} 
16:26:35.921 [http-nio-8080-exec-4] INFO  com.lingsh.service.UserService - getData	 json: {"method":"getData","content":"users"}
16:26:35.924 [http-nio-8080-exec-5] INFO  com.lingsh.service.UserService - valid	 get id: user#admin#1568535992934#
all users: {user#admin#1568535992934#=User {id=1, account='admin', password='123456', name='lingsh1'}}
16:26:35.928 [http-nio-8080-exec-5] INFO  com.lingsh.servlet.AjaxServlet - 后台传出的消息: {"ret":"success","msg":""} 1568535995927
16:26:35.973 [http-nio-8080-exec-4] INFO  com.lingsh.service.UserService - getUsersJson	 result: [**]
16:26:35.976 [http-nio-8080-exec-4] INFO  com.lingsh.servlet.AjaxServlet - 后台传出的消息: {"ret":"success","msg":"***"} 1568535995976
```
                            
#### 2. 排查问题
1. AjaxServlet.java 输入和返回的值 查看日志 没有问题
2. login.js 发现一个现象 之前因为开发进度问题搁置 就是html的form提交中onsubmit无法拦截(即使return false 也能跳转)   
    在chrome断点debug中发现ajax没有接受完信息就跳转页面了  
    想到ajax有两种工作方式:异步和同步, 默认为异步,即可以不用等待响应就进行js其他工作  

### 解决办法
更改login.js的ajax工作方式 为同步 此步骤需要阻塞等待响应

### 部分代码
#### 前端
#### html的form
```html
<%-- 提交form到main.jsp 通过onsubmit拦截 "return false"则不能提交 --%>
<form class="uk-panel uk-panel-box uk-form" action="main.jsp" method="post" onsubmit="return login()">
    ...
    <div class="uk-form-row">
        <button class="uk-width-1-1 uk-button uk-button-primary uk-button-large" type="submit">登录</button>
    </div>
    ...
</form>
```
##### 跳转页面之前的js判断
```js
function login() {
    var account = $("#account").val();
    var password = $("#password").val();
    var auth = $("input:radio:checked").val();
    var timestamp = new Date().getTime();

    // 跳转问题 是另外一个问题 ajax不在onsubmit生效的问题
    // 需要使用全局变量 ajax内部返回似乎没有 主要需要设置ajax为同步!
    var res = false;
    
    if (account !== "" && password !== "") {
        $.ajax({
            url: 'ajax/AjaxServlet',
            type: 'post',
            // 将Ajax设置为同步方式
            async: false,
            data: {
                method: 'login',
                account: account,
                password: password,
                auth: auth,
                timestamp: timestamp
            },
            dataType: 'json',
            success: function (args) {
                var ret = args.ret;
                var msg = args.msg;
                console.log(args);
                // 暂停查看打印日志
                alert("pause");
                if (ret === "success") {
                    res = true;
                } else {
                    console.log(args);
                    alert(msg);
                }
            },
            error: function (args) {
                alert('ajax error!');
                console.log(args);
            }
        })
    } else {
        alert("用户账号或密码不能为空!");
    }
    
    return res;
}
```
### 后台
#### AjaxServlet
```java
/**
 * 使用Ajax与Servlet交换信息
 *
 * @author lingsh
 * @version 1.0
 * @date 19-9-9 下午10:58
 */

public class AjaxServlet extends HttpServlet {
    
    // ...
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setCharacterEncoding("utf-8");
        req.setCharacterEncoding("utf-8");

        LOGGER.info("ajax --> servlet (by post)");

        // 获取变量 (方法名method, 参数列表json)
        String method = req.getParameter("method");
        String content = req.getParameter("content");
        String json = FormUtils.toJson(FormUtils.toMap(req));
        LOGGER.info(String.format("POST 前端传入的参数: %s ", json));
        // 通过反射调用方法 工作
        String result = (String) ReflectUtils.bindValueToMethod(getContent(content), method, json);
        LOGGER.info(String.format("后台传出的消息: %s %s", result, System.currentTimeMillis()));

        resp.setContentType("application/json;charset=utf-8");
        PrintWriter writer = resp.getWriter();
        writer.print(result);
        writer.flush();
    }

    // ...
}
```
#### UserService
```java
/**
 * 用户服务类
 * 将jsp的逻辑代码和业务合集
 *
 * @author lingsh
 * @version 1.0
 * @date 19-9-8 下午11:59
 */

public class UserService implements Constant {

    /**
    * 用户登录方法
    * @param json 前端传入的json数据 需要进行转换成Map对象使用
    * @return json数据 {成功/失败, 信息}
    */
    public static String login(String json) {
        LOGGER.info(String.format("login\t 登录前 先查看所有已登录用户\n %s", loginUsers));

        Map params = FormUtils.fromJson(json);
        LOGGER.info(String.format("login\t 前端传入参数列表 %s", params));

        String account = gets(params, ACCOUNT);
        String password = gets(params, PASSWORD);
        String auth = gets(params, AUTH);
        String timestamp = gets(params, TIMESTAMP);

        User user = getUser(account, auth);
        LOGGER.info(String.format("login\t 数据库查询到的用户 user:%s", user));

        if (Objects.isNull(user) || !Objects.equals(user.getPassword(), password)) {
            LOGGER.error(String.format("login\terror %s", ERROR_INPUT_USER_PWD));
            return FormUtils.toJson(sets(FAILED, ERROR_INPUT_USER_PWD));
        }

        String id = concatId("#", auth, account, timestamp);
        loginUsers.put(id, user);
        LOGGER.info(String.format("login\t 当前登录列表 users: %s", loginUsers));

        return FormUtils.toJson(sets(SUCCESS, SUCCESS_MSG));
    }
}
```
### 日志
#### 正确打印日志
```text
16:30:42.831 [http-nio-8080-exec-8] INFO  com.lingsh.servlet.AjaxServlet - ajax --> servlet (by post)
16:30:42.832 [http-nio-8080-exec-8] INFO  com.lingsh.servlet.AjaxServlet - POST 前端传入的参数: {"password":"123456","method":"login","auth":"user","account":"admin","timestamp":"1568536242822"} 
16:30:42.835 [http-nio-8080-exec-8] INFO  com.lingsh.service.UserService - login	 登录前 先查看所有已登录用户 {}
16:30:42.838 [http-nio-8080-exec-8] INFO  com.lingsh.service.UserService - login	 前端传入参数列表 {password=123456, method=login, auth=user, account=admin, timestamp=1568536242822}
Query By Account:select * from users where account=?
16:30:42.851 [http-nio-8080-exec-8] INFO  com.lingsh.service.UserService - login	 数据库查询到的用户 user:User {id=1, account='admin', password='123456', name='lingsh1'}
16:30:42.852 [http-nio-8080-exec-8] INFO  com.lingsh.service.UserService - login	 当前登录列表 users: {user#admin#1568536242822#=User {id=1, account='admin', password='123456', name='lingsh1'}}
16:30:42.853 [http-nio-8080-exec-8] INFO  com.lingsh.servlet.AjaxServlet - 后台传出的消息: {"ret":"success","msg":""} 1568536242852

16:30:44.756 [http-nio-8080-exec-3] INFO  com.lingsh.servlet.AjaxServlet - ajax --> servlet (by post)
16:30:44.757 [http-nio-8080-exec-3] INFO  com.lingsh.servlet.AjaxServlet - POST 前端传入的参数: {"method":"valid","id":"user#admin#1568536242822#"} 
16:30:44.758 [http-nio-8080-exec-3] INFO  com.lingsh.service.UserService - valid	 {"method":"valid","id":"user#admin#1568536242822#"}
16:30:44.760 [http-nio-8080-exec-3] INFO  com.lingsh.service.UserService - valid	 get id: user#admin#1568536242822#
all users: {user#admin#1568536242822#=User {id=1, account='admin', password='123456', name='lingsh1'}}
16:30:44.761 [http-nio-8080-exec-3] INFO  com.lingsh.servlet.AjaxServlet - 后台传出的消息: {"ret":"success","msg":""} 1568536244761
```
