function pageLoad(sender, args) {
    $(document).ready(function () {
        $("#buyerImg").on('click',
            function () {
                $("#buyerImg").addClass("img_click");
                $("#sellerImg").removeClass("img_click");
            });

        $("#sellerImg").on('click',
            function () {
                $("#sellerImg").addClass("img_click");
                $("#buyerImg").removeClass("img_click");
            });

        if ($("#body_buyerR").is(':checked')) {
            $("#buyerImg").addClass("img_click");
            $("#sellerImg").removeClass("img_click");
        }
        else if ($("#body_sellerR").is(':checked')) {
            $("#sellerImg").addClass("img_click");
            $("#buyerImg").removeClass("img_click");
        }
    });
}