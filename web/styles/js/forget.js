function forget() {
    // 首先. 对所输入的账号和昵称进行判空
    var account = document.getElementById("account").value;
    var name = document.getElementById("name").value;
    if (account.trim().length === 0) {
        alert("账号不能为空!");
        return false;
    } else if (name.trim().length === 0) {
        alert("昵称不能为空!");
        return false;
    }

    // 其次. 对账号和昵称进行简单的格式判断
    // 没有错误信息这表示通过
    var r1 = document.getElementById("checkAccountResult").innerHTML.length;
    var r2 = document.getElementById("checkNameResult").innerHTML.length;
    if (r1 !== 0 || r2 !== 0) {
        alert("账号或昵称格式有误!");
        return false;
    }

    var auth = $.cookie("cur_auth");
    var data = {
        method: "forget",
        account: account,
        name: name,
        auth: auth
    };

    var res = false;
    ajaxPost(data, function (xhr) {
        alert(xhr.msg);
        if (xhr.ret === "success") {
            res = true;
        }
    });

    return res;
}