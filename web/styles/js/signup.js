/**
 * 注册用户
 * @returns {boolean}
 */
function signup() {
    if (v()) {
        return signup_user($.cookie('cur_auth'));
    }
    return false;
}

/**
 * 前端输入数据检验
 * @returns {boolean}
 */
function v() {
    var r1 = document.getElementById("checkAccountResult").innerHTML.length;
    var r2 = document.getElementById("checkPasswordResult").innerHTML.length;
    var r3 = document.getElementById("checkPasswordEqualResult").innerHTML.length;
    var r4 = document.getElementById("checkNameResult").innerHTML.length;

    var checkFormResult = document.getElementById("checkFormResult");
    if (r1 + r2 + r3 + r4 > 0) {
        checkFormResult.innerHTML = "需要满足所有格式";
        return false;
    }
    return true;
}

/**
 * 注册用户的主函数
 * @param auth 当前权限
 * @returns {boolean}
 */
function signup_user(auth) {
    var account = document.getElementById("account").value;
    var password = document.getElementById("password").value;
    var name = document.getElementById("name").value;

    var data = {
        method: "signup",
        account: account,
        password: password,
        name: name,
        auth: auth
    };

    var res = true;
    ajaxPost(data, function (xhr) {
        alert(xhr.msg);
        if (xhr.ret === "success") {
            alert("返回页面");
        } else {
            res = false;
        }
    });
    return res;
}

/**
 * 新建用户 新建签到记录
 * 两个功能(另开了两个页面 但因为功能相识所以集中在此)
 */
function new_build_user() {
    if (v()) {
        return signup_user("user");
    }
    return false;
}

function new_build_sign() {
    var account = document.getElementById("account").value;
    var date = document.getElementById("signDate").value;
    var time = document.getElementById("signTime").value;

    var res = false;
    if (account !== "" && date !== "") {
        var data = {
            method: "register",
            content: "signs",
            account: account,
            timestamp: date + " " + time
        };
        ajaxPost(data, function (xhr) {
            if (xhr.ret === "success") {
                res = true;
            }
            alert(xhr.msg);
        })
    } else {
        alert("输入不能为空!");
    }
    return res;
}