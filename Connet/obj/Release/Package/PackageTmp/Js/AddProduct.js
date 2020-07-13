$(document).ready(() => {
    $(".custom-file-input").on("change", function () {
        var fileName = $(this).val().split("\\").pop();
        $(this).siblings(".custom-file-label").addClass("selected").html(fileName);
        $("#body_Prod_Img").imageURL($(this).val());
    });
});