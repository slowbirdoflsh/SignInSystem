$(document).ready(
    function () {
        var table = getQueryString("table");

        if (table === "recorder") {
            $("#canvas02").attr("class", "uk-active");
            $("#canvas01").attr("class", "");
        } else {
            $("#canvas01").attr("class", "uk-active");
            $("#canvas02").attr("class", "");
        }
    }
);

/**
 * @return {string}
 */
function getQueryString(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
    //search,查询？后面的参数，并匹配正则
    var r = window.location.search.substr(1).match(reg);
    if (r != null) {
        return unescape(r[2]);
    }
    return null;
}
