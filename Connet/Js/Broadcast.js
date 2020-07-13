$(function () {
    var connection = new RTCMultiConnection();
    var roomid;
    var imageCapture;

    // Start connection
    $.connection.hub.start().done(function () {
        console.log("Signalr Connected");

        

        $(function () {
            roomid = $("#body_roomid").val();
            window.enableAdapter = true;

            connection.codecs.video = "H264";

            connection.socketURL = "https://rtcmulticonnection.herokuapp.com:443/";
            //connection.setCustomSocketHandler(SignalRConnection);

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

            connection.session.oneway = true;

            connection.sdpConstraints.mandatory = {
                OfferToReceiveAudio: false,
                OfferToReceiveVideo: false
            };

            connection.open(roomid);

            connection.onstream = function (event) {
                if (event.type === "local") {
                    try {
                        document.getElementById("broadcast").srcObject = event.stream;

                    } catch (e) {
                        document.getElementById("broadcast").src = URL.createObjectURL(event.stream);
                    }
                }
            };
        });

        var viewChat = $.connection.publicHub;
        // Declare function on the chat hub
        viewChat.client.sendMessage = function (roomID, name, message) {
            // Html encode display name and message
            if (roomid === roomID) {
                var username = $("<div />").text(name).html();
                var chatMessage = $("<div />").text(message).html();
                if (name === $("#body_sellerField").val())
                    $("#chatContent").append("<div class='sender'>" + "<p>" + username + "</p>" + "<li>" + chatMessage + "</li>" + "</div>");
                else
                    $("#chatContent").append("<div class='receiver'>" + "<p>" + username + "</p>" + "<li>" + chatMessage + "</li>" + "</div>");
            }
        };

        $("#btnSend").click(function (e) {
            e.preventDefault();
            if ($("#txtMessage").val() && $("#body_sellerField").val()) {
                viewChat.server.sendToAll(roomid, $("#body_sellerField").val(), $("#txtMessage").val());
                $("#txtMessage").val("").focus();
            }
        });

        setInterval(function () {
            $("#views").text(connection.getAllParticipants().length);
            viewChat.server.viewSend(roomid, connection.getAllParticipants().length);
        }, 1000);

        setInterval(function() {
            var canvas = document.getElementById('screenshot_img');
            var ctx = canvas.getContext('2d');
            ctx.drawImage(document.getElementById("broadcast"), 0, 0, canvas.width, canvas.height);
            var dataURI = canvas.toDataURL('image/jpeg');
            viewChat.server.imageBit(dataURI, roomid);
        }, 5000);
        
        $(window).bind("beforeunload", function () {
            viewChat.server.broadcastEnd(roomid);
        });

        $(window).bind("unload", function () {
            viewChat.server.broadcastEnd(roomid);
        });
    });

    $('#txtMessage').enterKey(() => {
        $('#btnSend').trigger('click');
    });
});