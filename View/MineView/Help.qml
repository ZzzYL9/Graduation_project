import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import "../"

Page {
    id: page
    Keys.onPressed: {
        if(event.key==Qt.Key_Back){
            event.accepted=true;
            swipeview.interactive=true
            basebar.visible=true
            wodepage.clear()
        }
    }

    Text {
        text: qsTr("帮助")
        anchors.centerIn: parent
    }

    Rectangle {
        id: rectangle
        height: 50
        color: "#ffffff"
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0

        MouseArea {
            anchors.fill: parent
        }
        Text {
            id: element
            width: 30
            height: 26
            text: qsTr("帮助")
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 12
        }

        Button {
            flat: true
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.top: parent.top
            anchors.topMargin: 10
            height:30
            width: 30
            Image {
                anchors.fill: parent
                source: "qrc:/Images/common/back1.png"
            }
            onClicked:{
                MineView.interactive=true
                basebar.visible=true
                wodepage.clear();
            }
        }
        Rectangle {
            width: parent.width
            height: 1
            color: "#d2d2d2"
            anchors.bottom:parent.bottom
        }
    }
}
