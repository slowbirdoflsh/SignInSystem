function ajaxPost(data, success) {
    $.ajax({
        url: 'ajax/AjaxServlet',
        type: 'post',
        async: false,
        data: data,
        dataType: 'json',
        success: success,
        error: function (args) {
            alert('ajax error!');
            console.log(args);
        }
    })
}
