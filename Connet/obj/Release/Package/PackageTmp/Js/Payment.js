$(document).ready(function () {
    $('input[type=radio]').on('click',
        function () {
            $('.address_wrapper').removeClass("address_click");
            $('#' + $(this).val()).addClass("address_click");
            $('input[type=radio]').prop('checked', false);
            $(this).prop('checked', true);
        });

    if ($('input[type=radio]').is(':checked')) {
        $("#" + $('input[type=radio]:checked').val()).addClass("address_click");
    }
});