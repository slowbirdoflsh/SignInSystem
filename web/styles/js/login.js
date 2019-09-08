function login() {
    // 首先. 对所输入的账号和密码进行判空
    var account = document.getElementById("account").value;
    var password = document.getElementById("password").value;
    if (account.trim().length === 0) {
        alert("账号不能为空!");
        return false;
    } else if (password.trim().length === 0) {
        alert("密码不能为空!");
        return false;
    }

    // 其次. 对账号和密码进行简单的格式判断
    // 没有错误信息这表示通过
    var r1 = document.getElementById("checkAccountResult").innerHTML.length;
    var r2 = document.getElementById("checkPasswordResult").innerHTML.length;
    if (r1 !== 0 || r2 !== 0) {
        alert("账号或密码格式有误!");
        return false;
    }

    return true;
}

