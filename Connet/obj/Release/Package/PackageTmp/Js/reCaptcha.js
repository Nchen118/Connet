$(document).ready(function () {
    grecaptcha.ready(function () {
        grecaptcha.execute('6LcfRpgUAAAAAGHUfNzRfv9v5IoUVsH84-5ZgiPQ', { action: 'login' }).then(function (token) {
            $("#body_recaptcha_token").val(token);
        });
    });
});
