$(document).ready(() => {
    $('input[type=checkbox]').on('click',
        function () {
            $("#" + this.value).toggleClass("checked_item");
        });
});