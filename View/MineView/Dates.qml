import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import "../"

StackView{
    id: date
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
            text: qsTr("签到")
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
            width: parent.width
            height: 1
            color: "#d2d2d2"
            anchors.bottom:parent.bottom
        }


    }

    property string nowtime: Qt.formatDateTime(new Date(), "yyyy-M-d")
    property string selecttime:""
    property var myArray:new Array()

    function dayValid(date){
        datetext.text="本月已签到"+myArray.length+"天，今日未签到"
        for(var i = 0; i < myArray.length;i++)
        {
            if (myArray[i] === date)
            {
                return(false);
            }
        }
        return(true);
    }

    Rectangle {
        id: rectangle
        color: "#ffffff"
        anchors.top: parent.top
        anchors.topMargin: 50
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.left: parent.left

        Text {
            id:datetext
            text: ""
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Calendar {
            width: date.height/3
            height: width
            anchors.centerIn: parent
            navigationBarVisible:  false
            style: CalendarStyle {
                gridVisible: true
                dayDelegate: Rectangle {
                    property bool dayIsValid: dayValid(styleData.date.getDate().toString())
                    color:styleData.visibleMonth && !dayIsValid?"#CCCCCC":(styleData.visibleMonth &&styleData.selected? "#148014":"#FFFFFF")
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            selecttime=Qt.formatDateTime(styleData.date, "yyyy-M-d")
                            if(selecttime==nowtime&&myArray[myArray.length-1]!=styleData.date.getDate().toString()){
                                myArray.push(styleData.date.getDate().toString())
                                parent.color="#CCCCCC"
                                label.color="green"
                                datetext.text="本月已签到"+myArray.length+"天，今日已签到"
                            }else{
                                //datetext.text="本月已签到"+myArray.length+"天"
                            }

                        }
                    }

                    Label {
                        id:label
                        color: styleData.visibleMonth&&!dayIsValid ? "green":(styleData.visibleMonth?"black":"#CCCCCC")
                        text: styleData.date.getDate()
                        anchors.centerIn: parent
                    }
                    Rectangle {
                        width: parent.width
                        height: 1
                        color: "#EEEEEE"
                        anchors.bottom: parent.bottom
                    }
                    Rectangle {
                        width: 1
                        height: parent.height
                        color: "#EEEEEE"
                        anchors.right: parent.right
                    }

                }
            }
        }
    }

}
