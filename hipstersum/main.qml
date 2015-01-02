import QtQuick 2.2
import QtQuick.Controls 1.1

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    menuBar: MenuBar {
        Menu {
            title: qsTr("File")
            MenuItem {
                text: qsTr("Exit")
                onTriggered: Qt.quit();
            }
        }
    }
    HttpRequest {
        id: httpRequest

        onRequestFinished: {
            console.log("Reply finished Status:", status)

            if (status === 200) {
                // console.log("ResponseText", textReply)
            }
        }
    }

    Item {
        id: _Item_Container

        anchors.fill: parent
        Text {
            id: _Text_Paragraph
            anchors {
                top: _Item_Container.top; topMargin: 20
                left: _Item_Container.left; leftMargin: 20
            }
            text: "Paragraphs:"
            font.family: "Helvetica"
            font.pixelSize: 40
            color: "#000000"
        }

        TextInput {
            id: _Text_Input

            anchors {
                top: _Item_Container.top; topMargin: 20
                left:  _Text_Paragraph.right; leftMargin: 20
            }
            width: 240
            font.family: "Helvetica"
            font.pixelSize: 40
            color: "#000000"
            focus: true
            text: qsTr("4")
        }
        Rectangle {
            id: _Button
            anchors {
                top: _Item_Container.top; topMargin: 20
                left: _Text_Input.right; leftMargin: 20
            }
            width: 250
            height: 100
            color: "steelblue"
            Text {
                anchors.centerIn: parent
                text: "Beer me!"
                font.pixelSize: 40
                font.family: "Helvetica"
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    httpRequest.get("http://hipsterjesus.com/api/" , function(reply) {
                        // console.log("Reply was succesful:", reply.responseText)
                        var jsonReply = JSON.parse(reply.responseText)

//                        if (jsonReply.hasOwnProperty("paras")) {
                            _Text_Main.text = jsonReply["text"]
//                        }
                    }, function(reply) {
                        // console.log("Reply got an error:", reply.status)
                        _Text_Main.text = "Couldn't retrieve ip"
                    })
                    console.log(_Text_Input.text)
                }
            }
        }

        Text {
            id: _Text_Main
            anchors {
                centerIn: parent
                top: _Text_Paragraph.bottom; topMargin: 20
            }
            font.pixelSize: 40
            text: "caca"
        }
    }
}
