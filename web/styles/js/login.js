/**
 * 登录
 * @returns {boolean}
 */
function login() {
    var account = $("#account").val();
    var password = $("#password").val();
    var auth = $("input:radio:checked").val();
    var timestamp = new Date().getTime();

    save_cookies(account, password, auth, timestamp);

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
                // alert("pause");
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

/**
 * 记住密码功能
 */
function save_cookies(account, password, auth, timestamp) {
    if ($("#rem").prop("checked")) {
        $.cookie("rem", "true", {expires: 7});
        $.cookie("account", account, {expires: 7});
        $.cookie("password", password, {expires: 7});
    } else {
        $.cookie("rem", "false", {expires: -1});
        $.cookie("account", "", {expires: -1});
        $.cookie("password", "", {expires: -1});
    }

    // 传递到main.jsp界面
    auth = $("input:radio:checked").val();
    var id = auth + "#" + account + "#" + timestamp + "#";
    $.cookie("id", id, {expires: 7});
}

/**
 * 面向注册和忘记密码两个页面的cookie传值
 */
function set_cur_auth() {
    auth = $("input:radio:checked").val();
    $.cookie("cur_auth", auth, {expires: 7});
}

function del_cur_auth() {
    $.cookie("cur_auth", "", {expires: -1});
}