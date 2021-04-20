import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import "../"

StackView{
    id:shezhi
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
        id: rectangle4
        anchors.fill: parent
        MouseArea{
            anchors.fill: parent
        }
        Rectangle{
            id:rectangle2
            height: 50
            color: "#ffffff"
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
            Text {
                width: 30
                height: 26
                text: qsTr("设置")
                font.family: "方正楷体_GBK"
                anchors.horizontalCenter: parent.horizontalCenter
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
                    wodepage.clear();
                }

            }

            Rectangle {
                id: rectangle1
                width: parent.width
                height: 1
                color: "#d2d2d2"
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0
            }
        }

        Rectangle {
            id: rectangle
            color: "#f4f4f4"
            width: parent.width
            height: listView.height
            anchors.top: rectangle2.bottom
            anchors.topMargin: 0
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.left: parent.left

            ListView {
                id: listView
                width: parent.width
                spacing: 0
                anchors.fill: parent
                clip: true
                interactive: false
                ScrollBar.vertical: ScrollBar { }
                delegate: Item {
                    width: parent.width
                    height: 60
                    Rectangle {
                        id: rectangle3
                        width: parent.width
                        height: 60
                        //color: ""

                        Text {
                            text: name
                            font.family: "方正楷体_GBK"
                            font.pointSize: rectangle3.height-45
                            anchors.left: parent.left
                            anchors.leftMargin: 20
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Rectangle{
                            id:rectangle5
                            width: parent.width-20
                            height: 1
                            color: "#d2d2d2"
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 0
                            anchors.right: parent.right
                            anchors.rightMargin: 0
                        }
                    }
                }
                model: ListModel {
                    ListElement {
                        name: "通用设置"
                        sources: ""
                    }

                    ListElement {
                        name: "隐私设置"
                        sources: ""
                    }

                    ListElement {
                        name: "清理缓存"
                        sources: ""
                    }

                    ListElement {
                        name: "关于我们"
                        sources: ""
                    }
                }
            }
        }
    }





}
