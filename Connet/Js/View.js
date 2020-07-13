$(function () {
    var room_id = $("#body_roomID").val();

    $(function () {
        window.enableAdapter = true;

        var connection = new RTCMultiConnection();

        connection.codecs.video = "H264";

        connection.mediaConstraints = {
            video: {
                mandatory: {
                    minWidth: 1280,
                    maxWidth: 1980,
                    minHeight: 720,
                    maxHeight: 1080,
                    minFrameRate: 30,
                    minAspectRatio: 1.77
                },
                optional: [
                    {
                        facingMode: "user" // or "application"
                    }
                ]
            },
            audio: {
                mandatory: {
                    echoCancellation: true, // disabling audio processing
                    googAutoGainControl: true,
                    googNoiseSuppression: true,
                    googHighpassFilter: true,
                    googTypingNoiseDetection: true,
                    //googAudioMirroring: true
                },
                optional: []
            }
        };

        connection.session = {
            audio: false,
            video: false,
            oneway: true // only first person shares the video
        };

        connection.sdpConstraints.mandatory = {
            OfferToReceiveAudio: false,
            OfferToReceiveVideo: false
        };

        connection.socketURL = "https://rtcmulticonnection.herokuapp.com:443/";
        //connection.setCustomSocketHandler(SignalRConnection);

        connection.checkPresence(room_id, function (isRoomExist, roomid) {
            if (isRoomExist === true) {
                connection.join(roomid);
            } else {
                console.log("No room found");
                location.href = "../Error.aspx?errmsg=no room found";
            }
        });

        connection.onstream = function (event) {
            if (event.type === "remote") {
                try {
                    document.getElementById("view").srcObject = event.stream;
                } catch (e) {
                    document.getElementById("view").src = URL.createObjectURL(event.stream);
                }
                //setInterval(function () { $("#views").text(connection.getAllParticipants().length); }, 1000);
            }
        };

        //window.streamid = event.stream;
        //connection.streamEvents[event.streamid].stream.mute('audio');
    });

    var viewChat = $.connection.publicHub;
    // Declare function on the chat hub
    viewChat.client.sendMessage = function (roomID, name, message) {
        // Html encode display name and message
        if (roomID === room_id) {
            var username = $("<div />").text(name).html();
            var chatMessage = $("<div />").text(message).html();
            if (name === $("#body_userField").val())
                $("#chatContent").append("<div class='sender'>" + "<p>" + username + "</p>" + "<li>" + chatMessage + "</li>" + "</div>");
            else
                $("#chatContent").append("<div class='receiver'>" + "<p>" + username + "</p>" + "<li>" + chatMessage + "</li>" + "</div>");
        }
    };

    viewChat.client.viewReceive = function (roomID, views) {
        if (roomID === room_id) {
            $("#views").text(views);
        }
    };

    // Start connection
    $.connection.hub.start().done(function () {
        $("#btnSend").click(function (e) {
            e.preventDefault();
            if ($("#body_txtMessage").val() && $("#body_userField").val()) {
                viewChat.server.sendToAll(room_id, $("#body_userField").val(), $("#body_txtMessage").val());
                $("#body_txtMessage").val("").focus();
            }
        });
    });

    // Event
    $('#body_txtMessage').enterKey(() => {
        $('#btnSend').trigger('click');
    });

    if (!$('#body_userField').val()) {
        $('#body_txtMessage').prop('disabled', true);
        $('#btnSend').prop('disabled', true);
    }
});