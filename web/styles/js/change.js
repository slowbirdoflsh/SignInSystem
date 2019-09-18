function change() {
    // 首先. 对所输入的密码/新密码进行判空
    var password = document.getElementById("password").value;
    var password1 = document.getElementById("password1").value;
    if (password.trim().length === 0) {
        alert("密码不能为空!");
        return false;
    } else if (password1.trim().length === 0) {
        alert("新密码不能为空!");
        return false;
    }

    // 其次. 对密码进行简单的格式判断
    // 没有错误信息这表示通过
    var r1 = document.getElementById("checkNewPasswordResult").innerHTML.length;
    var r2 = document.getElementById("checkPasswordResult").innerHTML.length;
    document.getElementById("checkFormResult").innerHTML = "";
    if (r1 !== 0 || r2 !== 0) {
        alert("密码格式有误!");
        document.getElementById("checkFormResult").innerHTML = "密码格式有误";
        return false;
    }

    var arrs = getIdArrs();
    var data = {
        method: "change",
        account: arrs[1],
        auth: arrs[0],
        password: password + "#" + password1
    };

    var res = false;
    ajaxPost(data, function (xhr) {
        alert(xhr.msg);
        if (xhr.ret === "success") {
            res = true;
            alert("跳转到登录页面进行登录吧!");
            logout();
        }
    });
    return res;
}

function initChangeElements() {
    var header = document.getElementById("header");
    var arrs = getIdArrs();
    var middle = "";
    if (arrs[0] === "user") middle += "用户";
    else if (arrs[0] === "admin") middle += "管理员";
    middle += arrs[1];
    header.innerHTML = "修改" + middle + "密码";
}

function getIdArrs() {
    var id = $.cookie('id');
    return id.split('#');
}