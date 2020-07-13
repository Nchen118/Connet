$.fn.enterKey = function (fnc) {
    return this.each(function () {
        $(this).keypress(function (ev) {
            var keycode = (ev.keyCode ? ev.keyCode : ev.which);
            if (keycode == '13') {
                fnc.call(this, ev);
            }
        });
    });
}

$('#SearchBox').enterKey(() => {
    $('#hidden_search_btn').trigger('click');
});

$('#Username').enterKey(() => {
    $('#Login').trigger('click');
});

$('#Password').enterKey(() => {
    $('#Login').trigger('click');
});

$('.loadingBtn').on('click',
    function () {
        $(this).text('').append('<span class="spinner-grow spinner-grow-sm"></span> Loading..').addClass("disabled").prop("disabled", true);
    });
