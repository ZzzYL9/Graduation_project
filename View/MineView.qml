import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Window 2.2
import QtQuick.Layouts 1.0
import "./MineView"
import "./HomeView"
import "../common"

StackView{
    id:wodepage

    property bool onlogin: false
    property string username: ""
    property  string userimage: "qrc:/Images/my/headimg.png"
    width: rootwindow.width
    height:rootwindow.height
    Rectangle {
        id: rectangle
        color: "#ffffff"
        anchors.bottom: parent.verticalCenter
        anchors.bottomMargin: parent.height/10
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: parent.width/40
        anchors.left: parent.left
        anchors.leftMargin: parent.width/40

        Button {
            id: button1
            flat: true
            anchors.right: button2.left
            anchors.rightMargin: wodepage.width/50
            anchors.top: parent.top
            anchors.topMargin: wodepage.height/40
            Image {
                anchors.fill: parent
                source: ""
            }
            height: button3.height
            width: height
        }

        Button {
            id: button2
            flat: true
            anchors.right: parent.right
            anchors.rightMargin: wodepage.width/50
            anchors.top: parent.top
            anchors.topMargin: wodepage.height/40
            Image {
                anchors.fill: parent
                source: "qrc:/Images/my/settting1.png"
            }
            height: button3.height
            width: height
            onClicked: {
                wodepage.push(shezhi)
                swipeview.interactive=false
                basebar.visible=false
            }
        }

        Button {
            id: button3
            flat: true
            Text {
                text: qsTr("")
                font.family: "方正准圆简体"
                anchors.centerIn: parent
                font.pixelSize: parent.height-35
            }
            anchors.bottom: parent.bottom
            anchors.bottomMargin: wodepage.height/50
            anchors.right: parent.horizontalCenter
            anchors.rightMargin: wodepage.width*3/40
            height: wodepage.height*3/50
            width: wodepage.width/4
        }

        Button {
            id: button4
            flat: true
            Text {
                text: qsTr("")
                font.family: "方正准圆简体"
                anchors.centerIn: parent
                font.pixelSize: parent.height-35
            }
            anchors.bottom: parent.bottom
            anchors.bottomMargin: wodepage.height/50
            anchors.left: parent.horizontalCenter
            anchors.leftMargin: wodepage.width*3/40
            height: wodepage.height*3/50
            width: wodepage.width/4
        }

        Image {
            id: image
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            height: wodepage.height*4/25
            width: wodepage.width/5
            fillMode: Image.PreserveAspectFit
            source: onlogin ? userimage:"qrc:/Images/my/head.png"

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if(onlogin==false){
                        swipeview.interactive=false
                        basebar.visible=false
                        wodepage.push(login)
                    }
                }
            }
        }

        Text {
            id: element
            text: onlogin ? username:qsTr("未登录")
            font.family: "方正准圆简体"
            anchors.top: image.bottom
            anchors.topMargin: 0
            anchors.horizontalCenter: image.horizontalCenter
            font.pixelSize: button3.height-30
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if(onlogin==false){
                        swipeview.interactive=false
                        basebar.visible=false
                        wodepage.push(login)
                    }
                }
            }
        }
    }

    Rectangle {
        id: rectangle1
        color: "#ffffff"
        anchors.leftMargin: 23
        anchors.rightMargin: 23
        anchors.top: rectangle.bottom
        anchors.topMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.height/4
        anchors.left: parent.left
        anchors.right: parent.right

        GridLayout {
            anchors.fill: parent
            rows: 2
            columns: 3

            Button {
                id: button5
                flat: true
                Layout.fillHeight: true
                Layout.fillWidth: true
                Image {
                    height: button5.height/2
                    width: button5.height/2
                    anchors.centerIn: parent
                    source: "qrc:/Images/my/books.png"
                }
                Text{
                    text:qsTr("阅读历史")
                    font.pixelSize: parent.height/8
                    font.family: "方正准圆简体"
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: button5.horizontalCenter
                }
                Layout.preferredHeight: 80
                Layout.preferredWidth: 80
                onClicked: {
                    wodepage.push(shuji)
                    swipeview.interactive=false
                    basebar.visible=false
                }
            }

            Button {
                id: button6
                flat: true
                Layout.fillHeight: true
                Layout.fillWidth: true
                Image {
                    height: button6.height/2
                    width: button6.height/2
                    anchors.centerIn: parent
                    source: "qrc:/Images/my/note1.png"
                }
                Text{
                    text:qsTr("我的笔记")
                    font.pixelSize: parent.height/8
                    font.family: "方正准圆简体"
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: button6.horizontalCenter
                }
                Layout.preferredHeight: 80
                Layout.preferredWidth: 80
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                onClicked: {
                    wodepage.push(biji)
                    swipeview.interactive=false
                    basebar.visible=false
                }
            }

            Button {
                id: button7
                flat: true
                Layout.columnSpan: 1
                Layout.rowSpan: 1
                Layout.fillHeight: true
                Layout.fillWidth: true
                Image {
                    height: button7.height/2
                    width: button7.height/2
                    anchors.centerIn: parent
                    source: "qrc:/Images/my/info.png"
                }
                Text{
                    text:qsTr("我的信息")
                    font.pixelSize: parent.height/8
                    font.family: "方正准圆简体"
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: button7.horizontalCenter
                }
                Layout.preferredHeight: 80
                Layout.preferredWidth: 80
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                onClicked: {
                    wodepage.push(xinxi)
                    swipeview.interactive=false
                    basebar.visible=false
                }
            }

            Button {
                id: button8
                flat: true
                Layout.fillHeight: true
                Layout.fillWidth: true
                font.family: "Courier"
                Image {
                    height: button8.height/2
                    width: button8.height/2
                    anchors.centerIn: parent
                    source: "qrc:/Images/my/account.png"
                }
                Text{
                    text:qsTr("我的账户")
                    font.pixelSize: parent.height/8
                    font.family: "方正准圆简体"
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: button8.horizontalCenter
                }
                Layout.preferredHeight: 80
                Layout.preferredWidth: 80
                onClicked: {
                    wodepage.push(zhanhu,{"iflogin":onlogin})
                    swipeview.interactive=false
                    basebar.visible=false
                }
            }

            Button {
                id: button9
                flat: true
                Layout.fillHeight: true
                Layout.fillWidth: true
                Image {
                    height: button9.height/2
                    width: button9.height/2
                    anchors.centerIn: parent
                    source: "qrc:/Images/my/sign1.png"
                }
                Text{
                    text:qsTr("签到")
                    font.pixelSize: parent.height/8
                    font.family: "方正准圆简体"
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: button9.horizontalCenter
                }
                Layout.preferredHeight: 80
                Layout.preferredWidth: 80
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                onClicked: {
                    wodepage.push(date)
                    swipeview.interactive=false
                    basebar.visible=false
                }
            }

            Button {
                id: button10
                flat: true
                Layout.fillHeight: true
                Layout.fillWidth: true
                Image {
                    height: button10.height/2
                    width: button10.height/2
                    anchors.centerIn: parent
                    source: "qrc:/Images/my/help.png"
                }
                Text{
                    text:qsTr("帮助")
                    font.pixelSize: parent.height/8
                    font.family: "方正准圆简体"
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: button10.horizontalCenter
                }
                Layout.preferredHeight: 80
                Layout.preferredWidth: 80
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                onClicked: {
                    wodepage.push(findpage)
                    swipeview.interactive=false
                    basebar.visible=false
                }

            }
        }
    }



    Component{
        id:shuji
        MyBooks{}
    }
    Component{
        id:biji
        MyNotes{}
    }
    Component{
        id:xinxi
        MyInfo{}
    }
    Component{
        id:zhanhu
        MyAccount{}
    }
    Component{
        id:date
        Dates{}
    }
    Component{
        id:banzhu
        Help{}
    }
    Component{
        id:shezhi
        Setting{}
    }
    Component{
        id:login
        LoginView{}
    }
    Component{
        id:findpage
        SortView{}
    }

}


