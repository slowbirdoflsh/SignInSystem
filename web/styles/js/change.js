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

    return true;
}

