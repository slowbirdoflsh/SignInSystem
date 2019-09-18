/**
 * 主页面初始化
 * 顶栏 topElements
 * 侧边导航栏 slideElements
 * 中间主内容 mainTable
 */
function initElements() {
    var id = $.cookie('id');
    var arrs = id.split('#');
    var auth = arrs[0];
    var account = arrs[1];

    topElements(auth, account);
    slideElements(auth, account);
    mainTable(auth, auth === "admin" ? "users" : "signs");
}

function topElements(auth, account) {
    var welcome = document.getElementById("welcome");
    var search = document.getElementById("search");
    var new_build = document.getElementById("new_build");
    var sign_bth = document.getElementById("sign_btn");

    if (auth === 'admin') {
        welcome.innerHTML = "欢迎管理员 " + account + " 登录";
        search.placeholder = "搜索用户表用户账号";
        // sign_bth.hidden = true;
        sign_bth.style.display = "none";
    } else if (auth === 'user') {
        welcome.innerHTML = "欢迎用户 " + account + " 登录";
        search.placeholder = "搜索签到表用户姓名";
        new_build.hidden = true;
    } else {
        console.log("auth " + auth + "account" + account);
        alert("auth == ?");
    }
}

function slideElements(auth, account) {
    //document.getElementById("canvas02").classList.value
    var canvas01 = document.getElementById("canvas01");
    var canvas02 = document.getElementById("canvas02");
    var op_name = document.getElementById("op_name");

    if (auth === "user") {
        canvas01.classList.value = "";
        canvas01.hidden = true;
        canvas02.classList.value = "uk-active";
        op_name.innerHTML = "用户操作";
    }
}

function mainTable(auth, content) {
    setTableHeader(auth, content);
    setTableBody(auth, content);
    setCurTable(content);
}

function mainTableUsers() {
    mainTable(getAuth(), "users");
    setActive("users");
    return false;
}

function mainTableSign() {
    mainTable(getAuth(), "signs");
    setActive("signs");
    return false;
}

function getUserHeader(auth) {
    var header = "<th>编号</th>" +
        "<th>用户账号</th>" +
        "<th>密码</th>" +
        "<th>名称</th>";
    return header + getExtOptHeader(auth);
}

function getSignHeader(auth) {
    var header = "<th>用户名称</th>" +
        "<th>编号</th>" +
        "<th>签到时间</th>" +
        "<th>用户编号</th>";
    return header + getExtOptHeader(auth);
}

function setTableHeader(auth, content) {
    var thead = document.getElementById("thead");
    if (auth === 'admin') {
        if (content === "signs") {
            thead.innerHTML = getSignHeader(auth);
        } else {
            thead.innerHTML = getUserHeader(auth);
        }
    } else if (auth === 'user') {
        thead.innerHTML = getSignHeader(auth);
    } else {
        alert("don't known auth " + auth);
    }
}

function getExtOptHeader(auth) {
    var cont = "";
    if (auth === "admin") {
        cont += "<th>修改</th>" +
            "<th>删除</th>"
    }
    return cont;
}

function setBody(auth, msg) {
    console.log(msg);

    var json = eval("(" + msg + ")");
    var tds = "";
    for (var i = 0; i < json.length; i++) {
        tds += "<tr>";
        for (var key in json[i]) {
            tds += "<td>" + json[i][key] + "</td>";
        }
        tds += getExtOptBody(auth);
        tds += "</tr>";
    }
    console.log(tds);
    var tbody = document.getElementById("tbody");
    tbody.innerHTML = tds;
}

function setTableBody(auth, content) {
    var data = {};
    if (auth === "admin") {
        data = {
            method: "getData",
            content: content
        };
    } else if (auth === "user") {
        data = {
            method: "getData",
            content: content
        };
    }
    setTableBodyData(auth, data);
}

function setBodySingl(auth, msg) {
    var json = eval("(" + msg + ")");
    var tds = "<tr>";
    for (var key in json) {
        tds += "<td>" + json[key] + "</td>";
    }
    tds += getExtOptBody(auth);
    tds += "</tr>";
    console.log(tds);
    var tbody = document.getElementById("tbody");
    tbody.innerHTML = tds;
}

function setTableBodyData(auth, data) {
    ajaxPost(data, function (xhr) {
        if (xhr.ret === "success") {
            setBody(auth, xhr.msg);
        } else {
            console.log(xhr);
            alert(xhr.msg);
        }
    });
}

function getExtOptBody(auth) {
    var cont = "";
    if (auth === "admin") {
        cont += getButton("td", "修改", "inChange(this)' data-uk-modal='{target:\"#dialog\"}") +
            getButton("td", "删除", "return inDelete(this)");
    }
    return cont;
}

function getButton(t, text, method) {
    return "<" + t + ">\n" +
        "    <div class=\"uk-button-group\">\n" +
        "        <a class=\"uk-button uk-button-danger\"href='' onclick='" + method + "'>" + text + "</a>\n" +
        "   </div>\n" +
        "   </" + t + ">";
}

/**
 * 通过表格内容切换侧边栏活动状态
 * @param content 表格内容 "users" "signs"
 */
function setActive(content) {
    var canvas01 = document.getElementById("canvas01");
    var canvas02 = document.getElementById("canvas02");

    if (content === "signs") {
        canvas01.classList.value = "";
        canvas02.classList.value = "uk-active";
    } else {
        canvas02.classList.value = "";
        canvas01.classList.value = "uk-active";
    }
}

/**
 * 获取当前权限
 * @returns {string} "user/admin"
 */
function getAuth() {
    var id = $.cookie('id');
    var arrs = id.split('#');
    return arrs[0];
}

/**
 * 获取当前账号
 * @returns {string} account
 */
function getAcc() {
    var id = $.cookie('id');
    var arrs = id.split('#');
    return arrs[1];
}

/**
 * 获取当前表格内容
 * @returns {*}
 */
function getCurTable() {
    return document.getElementById("cur_table").value;
}

function setCurTable(value) {
    document.getElementById("cur_table").value = value;
}

/**
 * ************************
 * 功能区
 * ************************
 */
/**
 * 登出
 */
function logout() {
    var id = $.cookie('id');
    var data = {
        method: 'logout',
        id: id
    };
    ajaxPost(data, function (xhr) {
        if (xhr.ret === "success") {
            alert(xhr.msg);
            $.cookie("id", id, {expires: -1});
            window.location.replace("login.jsp");
        } else {
            console.log(xhr);
            alert("this is a error of logout");
        }
    })
}

/**
 * 签到
 * @returns {boolean}
 */
function register() {
    var auth = getAuth();
    var account = getAcc();
    if (auth === "admin") {
        alert("你是管理员" + auth + " 无需签到!");
    } else {
        // 签到需要 用户id 和 当前时间
        ajaxPost({
            method: "register",
            account: account,
            content: "signs"
        }, function (xhr) {
            alert(xhr.msg);
            mainTableSign();
        });
    }
    return false;
}

/**
 * 搜索
 * @returns {boolean}
 */
function search() {
    var search_content = document.getElementById("search").value;
    var auth = getAuth();
    var cur_table = getCurTable();

    var data = {
        method: "search",
        content: cur_table,
        search: search_content
    };
    ajaxPost(data, function (xhr) {
        if (xhr.ret === "success") {
            if (cur_table === "user") {
                setBodySingl(auth, xhr.msg);
            } else {
                setBody(auth, xhr.msg);
            }
        } else {
            alert(xhr.msg);
        }
    });
    return true;
}

/**
 * 新建用户/签到记录
 */
function new_build() {
    var cur_table = getCurTable();
    var new_build = document.getElementById("new_build");
    if (cur_table === "users") {
        new_build.href = "new_build_user.jsp";
    } else if (cur_table === "signs") {
        new_build.href = "new_build_sign.jsp";
    } else {
        alert("这里有个错误!");
    }
}

/**
 * 删除 表格按钮
 * @param id 表格所在位置元素
 * @returns {boolean}
 */
function inDelete(id) {
    var cur = getTblRowByElement(id);
    var d0 = cur[0];
    var d1 = cur[1];
    var d2 = cur[2];
    var d3 = cur[3];
    var table = getCurTable();

    UIkit.modal.confirm('你确定要删除?',
        function () {
            // UIkit.modal.alert(decorate(getTblHeader(), cur));
            uc(table, d0, d1, d2, d3, "delete");
        });
    return false;
}

/**
 * 修改 表格按钮
 * @param id 表格所在位置元素
 */
function inChange(id) {
    var dh = getCurTable() === "users" ? "修改该用户" : "修改该记录";
    $("#dialog-header").html(dh);

    var ori = getTblRowByElement(id);
    var header = getTblHeader();
    injectInDialog(header, ori);
}

/**
 * 对话框初始信息注入
 * @param a1 标签
 * @param a2 数据
 */
function injectInDialog(a1, a2) {
    for (var i = 0; i < a1.length; i++) {
        $("#label-" + i).html(a1[i]);
        $("#dialog-" + i).val(a2[i]);
    }
}

function updateChange() {
    var d0 = $("#dialog-0").val();
    var d1 = $("#dialog-1").val();
    var d2 = $("#dialog-2").val();
    var d3 = $("#dialog-3").val();
    var table = getCurTable();

    UIkit.modal.confirm('你确定要修改?',
        function () {
            uc(table, d0, d1, d2, d3, "update");
        });
}

/**
 * update change
 */
function uc(table, d0, d1, d2, d3, method) {
    var data = "";
    if (table === "users") {
        data = ucu(d0, d1, d2, d3, method);
    } else if (table === "signs") {
        data = ucs(d0, d1, d2, d3, method);
    } else {
        alert("table " + table + " is valid!");
        return false;
    }

    data.content = table;
    ajaxPost(data, function (xhr) {
        if (xhr.ret === "success") {
            UIkit.modal.alert("修改成功");
            if (table === "users") mainTableUsers();
            else mainTableSign();
        } else {
            UIkit.modal.alert(xhr.msg);
        }
    })
}

/**
 * update change user
 */
function ucu(id, account, password, name, method) {
    return data = {
        method: method,
        id: id,
        account: account,
        password: password,
        name: name
    };
}

/**
 * update change sign
 */
function ucs(name, id, timestamp, userId, method) {
    return data = {
        method: method,
        id: id,
        name: name,
        timestamp: timestamp,
        userId: userId
    };
}

function getTblHeader() {
    var tbl = $("#display-tbl");
    var cols = tbl["0"].rows["0"].cells.length - 2;
    var res = new Array(cols);

    for (var i = 0; i < cols; i++) {
        res[i] = $("#display-tbl tr:eq(0) th:eq(" + i + ")").html();
    }
    return res;
}

function getTblRowByElement(id) {
    return getTblRow(id.parentNode.parentNode.parentNode.rowIndex);
}

function getTblRow(rowId) {
    var tbl = $("#display-tbl");
    var cols = tbl["0"].rows["0"].cells.length - 2;
    var rows = tbl["0"].rows.length;
    var res = new Array(cols);

    if (rowId > rows) return "";

    for (var i = 0; i < cols; i++) {
        res[i] = $("#display-tbl tr:eq(" + rowId + ") td:eq(" + i + ")").html();
    }
    return res;
}

function decorate(a1, a2) {
    var str = "";
    for (var i = 0; i < a1.length; i++) {
        str += a1[i] + ":" + a2[i] + "</br>";
    }
    return str;
}
