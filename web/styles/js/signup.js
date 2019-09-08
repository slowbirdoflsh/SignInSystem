function signup() {
    var r1 = document.getElementById("checkAccountResult").innerHTML.length;
    var r2 = document.getElementById("checkPasswordResult").innerHTML.length;
    var r3 = document.getElementById("checkPasswordEqualResult").innerHTML.length;
    var r4 = document.getElementById("checkNameResult").innerHTML.length;

    var checkFormResult = document.getElementById("checkFormResult");
    if (r1 === 0 && r2 === 0 && r3 === 0 && r4 === 0) {
        checkFormResult.innerHTML = "";
        return true;
    } else {
        checkFormResult.innerHTML = "需要满足所有格式";
        return false;
    }
}
