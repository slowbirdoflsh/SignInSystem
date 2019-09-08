function checkAccount(obj) {
    var account = obj;
    var checkAccountResult = document.getElementById("checkAccountResult");
    if (account.trim().length === 0) {
        checkAccountResult.innerHTML = "用户名不能为空";
    } else {
        checkAccountResult.innerHTML = "";
    }
}

function checkPassword(obj) {
    var password = obj;
    var checkPasswordResult = document.getElementById("checkPasswordResult");
    if (password.trim().length === 0) {
        checkPasswordResult.innerHTML = "密码不能为空";
    } else if (password.trim().length < 6) {
        checkPasswordResult.innerHTML = "密码不能小于6个字符";
    } else {
        checkPasswordResult.innerHTML = "";
    }
}

function checkNewPassword(obj) {
    var password = obj;
    var orgin = document.getElementById("password1").value;
    var checkNewPasswordResult = document.getElementById("checkNewPasswordResult");
    if (password.trim().length === 0) {
        checkNewPasswordResult.innerHTML = "密码不能为空";
    } else if (password.trim().length < 6) {
        checkNewPasswordResult.innerHTML = "密码不能小于6个字符";
    } else if (orgin.length !== 0 && orgin === password) {
        checkNewPasswordResult.innerHTML = "新密码不能与原密码相同";
    } else {
        checkNewPasswordResult.innerHTML = "";
    }
}

function checkPasswordEqual(obj) {
    var password = document.getElementById("password").value;
    var password2 = obj;
    var checkPasswordEqualResult = document.getElementById("checkPasswordEqualResult");
    if (password.trim().length === 0 || password2.trim().length === 0) {
        checkPasswordEqualResult.innerHTML = "请先输入密码";
        // obj.focus();
    } else if (password.trim() !== password2.trim()) {
        checkPasswordEqualResult.innerHTML = "确认密码与密码输入不一致";
        // obj.focus();
    } else {
        checkPasswordEqualResult.innerHTML = "";
    }
}

function checkName(obj) {
    var name = obj;
    var checkNameResult = document.getElementById("checkNameResult");
    if (name.trim().length === 0) {
        checkNameResult.innerHTML = "昵称不能为空";
        // obj.focus();
    } else {
        checkNameResult.innerHTML = "";
    }
}