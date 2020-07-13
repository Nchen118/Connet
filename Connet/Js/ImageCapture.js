var constraints = {
    facingMode: 'user',
    width: {
        ideal: 1280
    },
    height: {
        ideal: 720
    },
    aspectRatio: {
        ideal: 1.77
    }
};

navigator.mediaDevices.getUserMedia({
    video: constraints
}).then(function (camera) {
    if (typeof ImageCapture !== 'function' || getChromeVersion() < 60) {
        document.write('<h1>ImageCapture is NOT supported in this browser.</h1>');

        if (isChrome()) {
            document.write('<h1>Please upgrade to Chrome &gt;= 60 or try Canary/Beta.</h1>');
        }
        else {
            document.write('<h1>Please try Chrome browser.</h1>');
        }
        camera.getTracks().forEach(function (track) {
            track.stop();
        });
        return;
    }

    var firstVideoTrack = camera.getVideoTracks()[0];
    var imageCapture = new ImageCapture(firstVideoTrack);
    try {
        imageCapture.takePhoto().then(function (blob) {
            var photo = URL.createObjectURL(blob);

            // TODO


        }).catch(function (error) {
            if (typeof error !== 'string') {
                error = error.message || error.stack || error.name || error.toString();
            }

            document.write('<h1>Error: ' + error + '</h1>');

            camera.getTracks().forEach(function (track) {
                track.stop();
            });
        });
    } catch (e) {
        document.write('<h1>ImageCapture is NOT supported in this browser.</h1>');

        if (isChrome()) {
            document.write('<h1>Please upgrade to Chrome &gt;= 60 or try Canary/Beta.</h1>');
        }
        else {
            document.write('<h1>Please try Chrome browser.</h1>');
        }

        camera.getTracks().forEach(function (track) {
            track.stop();
        });
    }
}).catch(function (error) {
    if (typeof error !== 'string') {
        error = error.message || error.stack || error.name || error.toString();
    }

    document.write('<h1>getUserMedia error: ' + error + '</h1>');
});

function isChrome() {
    return !!window.chrome && !(!!window.opera || navigator.userAgent.indexOf(' OPR/') >= 0);
}

function getChromeVersion() {
    var raw = navigator.userAgent.match(/Chrom(e|ium)\/([0-9]+)\./);
    return raw ? parseInt(raw[2], 10) : false;
}