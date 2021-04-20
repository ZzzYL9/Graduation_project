import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import "../"
StackView {
    id: element
    anchors.fill: parent


    Keys.onPressed: {
        if(event.key==Qt.Key_Back){
            event.accepted=true;
            swipeview.interactive=true
            basebar.visible=true
            wodepage.clear()
        }
    }
    Rectangle{
    anchors.fill: parent
    MouseArea{
        anchors.fill: parent
    }

    Rectangle{
        height: 50
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0


        Text {
            width: 50
            height: 26
            text: qsTr("我的信息")
            fontSizeMode: Text.VerticalFit
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 12
        }

        Button {
            flat: true
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.top: parent.top
            anchors.topMargin: 10
            height: 30
            width: 30
            Image {
                anchors.fill: parent
                source: "qrc:/Images/common/back1.png"
            }
            onClicked:{
                MineView.interactive=true
                basebar.visible=true
                wodepage.clear()
            }
        }
        Rectangle {
            id: rectangle3
            width: parent.width

            height: 1
            color: "#d2d2d2"
            anchors.bottom:parent.bottom
        }


    }
    }
    Rectangle{
        id: rectangle
        //property string nowtime: Qt.formatDateTime(new Date(), "yyyy-MM-dd  hh-mm-ss  dddd")
        anchors.top: parent.top
        anchors.topMargin: 50
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        color: "#f4f4f4"
        ListView {
            id: listView
            spacing: 0
            highlightRangeMode: ListView.ApplyRange
            anchors.fill: parent
            cacheBuffer: 320
            clip: true
            opacity: 1
            transformOrigin: Item.Center
            scale: 1
            rotation: 0
            highlightResizeDuration: 0
            ScrollBar.vertical: ScrollBar { }
            model: ListModel {
                id:listmodel
                ListElement{
                    thename:"系统消息"
                    thetext:"A"
                    bookimage:"qrc:/Images/my/head.png"
                }
                ListElement{
                    thename:"系统消息"
                    thetext:"B"
                    bookimage:"qrc:/Images/my/head.png"
                }
            }
            delegate: component

        }
        Component{
            id:component
            Rectangle {
                id:rectangle1
                anchors.left: parent.left
                anchors.leftMargin:0
                width: parent.width
                height: 100
                Image {
                    id: image
                    source: bookimage
                    height: 50
                    width: 50
                    anchors.left: parent.left
                    anchors.top: parent.top
                }

                Text {
                    id: atext
                    text: thetext
                    font.family: "方正楷体_GBK"
                    anchors.top: name.bottom
                    anchors.topMargin: 5
                    anchors.left: image.right
                    anchors.leftMargin: 5
                    font.pixelSize: 12
                    elide: Text.ElideRight
                }

                Text {
                    id: name
                    text: thename
                    font.family: "方正楷体_GBK"
                    anchors.top: parent.top
                    anchors.topMargin: 5
                    anchors.left: image.right
                    anchors.leftMargin: 5
                    font.pixelSize: 15
                }

                Text {
                    id: time
                    color: "#848484"
                    font.family: "方正楷体_GBK"
                    text:"2020-3-20 20:10:30"
                    anchors.right: parent.right
                    anchors.rightMargin: 5
                    anchors.top: parent.top
                    anchors.topMargin: 5
                    font.pixelSize: 12
                }
                Rectangle {
                    id: rectangle2
                    width: parent.width-50
                    anchors.right: parent.right
                    height: 1
                    color: "#d2d2d2"
                    anchors.bottom: rectangle1.bottom
                    anchors.topMargin: 0
                }

            }
        }
    }

}

