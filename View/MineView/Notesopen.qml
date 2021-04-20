import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import "../"

Page {
    id:note

    property string txt: ""
    property int indx:-1

    Keys.onPressed: {
        if(event.key==Qt.Key_Back){
            event.accepted=true;
            mynotes.clear()
        }
    }
    Rectangle {
        id: rectangle
        height: 50
        color:  "#ffffff"
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0

        Button {
            id: button
            width: 30
            height: 30
            flat: true
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: 10
            Image {
                anchors.fill: parent
                source: "qrc:/Images/common/back1.png"
            }
            onClicked: {
                mynotes.clear()
            }
        }

        Button {
            id: button1
            visible: true
            width: 30
            height: 30
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.right: parent.right
            anchors.rightMargin: 10
            flat: true
            Image {
                anchors.fill: parent
                source: "qrc:/Images/my/go.png"
            }

            onClicked: {
                console.log(indx)
                mod.setProperty(indx,"txt",textEdit.text)
                textEdit.cursorVisible=false
                visible=false
            }
        }
        Rectangle {
            width: parent.width
            height: 1
            color: "#d2d2d2"
            anchors.bottom:parent.bottom
        }
    }

    Rectangle {
        id: rectangle1
        color: "#dddddd"
        anchors.top: rectangle.bottom
        anchors.topMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0

        Flickable{
            anchors.fill: parent
            contentHeight: textEdit.contentHeight<parent.height?parent.height:textEdit.contentHeight
            contentWidth: parent.width
            ScrollBar.vertical: ScrollBar { }
            TextEdit {
                id: textEdit
                text: txt
                anchors.rightMargin: 10
                anchors.leftMargin: 10
                anchors.fill: parent
                wrapMode: Text.WrapAnywhere
                clip: true
                font.pixelSize: 12
                onCursorVisibleChanged: {
                    if(cursorVisible==true){
                        button1.visible=true
                    }
                }
            }
        }
    }

}
