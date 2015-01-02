import QtQuick 2.0

Item {
    id: root

    property url targetUrl
    property int status
    property string textReply

    signal requestFinished

    function resetData() {
        textReply = ""
        status = 0
    }

    function httpRequest(url, operation, callback, callbackError) {
        var doc = new XMLHttpRequest();

        doc.onreadystatechange = function() {
            if (doc.readyState == XMLHttpRequest.HEADERS_RECEIVED) {
                // TODO: read headers if needed
            } else if (doc.readyState == XMLHttpRequest.DONE) {
                root.status = doc.status
                root.textReply = doc.responseText

                if (doc.status === 200)
                    callback(doc)
                else
                    callbackError(doc)

                root.requestFinished()
            }
        }

        doc.open(operation, url);
        doc.send();
    }

    function get(url, callBack, errorCallback) {
        targetUrl = url
        var functionCallback = callBack
        if (functionCallback === undefined) {
            functionCallback = function(reply) {
                console.log("All good")
            }
        }

        var functionCallbackError = errorCallback
        if (functionCallbackError === undefined) {
            functionCallbackError = function(reply) {
                console.log("All good")
            }
        }

        httpRequest(url, "GET", functionCallback, errorCallback)
    }

    function post(url) {
        targetUrl = url
        httpRequest(url, "POST", function(reply) {
            console.log("All good")
        }, function(reply) {
            console.log("Error")
        })
    }

    onTargetUrlChanged: resetData()
}
