import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import "../"

StackView{
    id:shezhi
    property bool iflogin: false
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
        MouseArea {
            anchors.fill: parent
        }
        Rectangle {
            id: rectangle5
            height: 50
            color: "#ffffff"
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0

            Text {
                id: element
                x: 308
                y: 9
                width: 50
                height: 26
                text: qsTr("我的账户")
                font.family: "方正楷体_GBK"
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

        Rectangle {
            id: rectangle
            x: 0
            y: 50
            color: "#f4f4f4"
            width: parent.width
            height: shezhi.height-50
            anchors.top: rectangle5.bottom
            anchors.topMargin: 0
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.left: parent.left

            ListView {
                id: listView
                width: parent.width
                height: contentHeight
                spacing: 0

                clip: true
                interactive: false
                ScrollBar.vertical: ScrollBar { }
                delegate: Item {
                    width: parent.width
                    height: 60
                    Rectangle {
                        id: rectangle1
                        width: parent.width
                        height: 60
                        //color: ""

                        Text {
                            text: name
                            font.family: "方正楷体_GBK"
                            font.pointSize: rectangle1.height-45
                            anchors.left: parent.left
                            anchors.leftMargin: 20
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Rectangle{
                            id:rectangle2
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
                        name: "修改密码"
                    }

                    ListElement {
                        name: "手机号码"
                    }

                    ListElement {
                        name: "最近登录"
                    }

                    ListElement {
                        name: "帐号注销"
                    }
                }
            }
            Rectangle {
                id: rectangle3
                width: parent.width
                height: 60
                anchors.top: listView.bottom
                visible: iflogin? true:false

                Text {
                    text: "退出登录"
                    font.family: "方正楷体_GBK"
                    font.pointSize: rectangle3.height-45
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    anchors.verticalCenter: parent.verticalCenter
                }
                Rectangle{
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



    }
}
