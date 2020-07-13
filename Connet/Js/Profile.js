$(document).ready(() => {
    $("#edit_p").on('click',
        () => {
            $("#Edit_Address").hide();
            $("#Edit_Profile").show();
        });

    $("#edit_a").on("click",
        () => {
            $("#Edit_Profile").hide();
            $("#Edit_Address").show();
        });

    $("#myProfile").on('click',
        () => {
            $("#My_Profile").show();
            $("#My_Products").hide();
        });

    $("#myProducts").on('click',
        () => {
            $("#My_Profile").hide();
            $("#My_Products").show();
        });
});