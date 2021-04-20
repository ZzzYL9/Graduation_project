import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Window 2.2
import QtQuick.Layouts 1.0
import "../"
import "../../"

StackView{
    id: wodeshuji
    anchors.fill: parent

    Keys.onPressed: {
        if(event.key==Qt.Key_Back){
            event.accepted=true;
            swipeview.interactive=true
            basebar.visible=true
            wodepage.clear()
        }
    }

    Rectangle {
        id: rectangle1
        height: 50
        color: "#ffffff"
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        MouseArea{
            anchors.fill: parent
        }

        Text {
            x: 295
            y: 0
            width: 50
            height: 26
            text: qsTr("阅读历史")
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

                swipeview.interactive=true
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
    Rectangle {
        id: rectangle
        //color: "#d8cccc"
        anchors.top: parent.top
        anchors.topMargin: 50
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0


        GridView {
            id:grid
            cellHeight: rectangle.height/3
            cellWidth: rectangle.width/3

            property int fillMode: Image.PreserveAspectFit
            anchors.rightMargin: 0
            anchors.bottomMargin: 0
            anchors.leftMargin: 0
            anchors.topMargin: 0
            anchors.fill: parent
            clip: true
            model:filesModel
            delegate: imageDelegate
        }

        ListModel{
            id:filesModel
            ListElement{
                filePath:"qrc:/book/help/help.jpg"
            }
            ListElement{
                filePath:"qrc:/book/xiaoshuo/xiaoshuo.jpg"
            }
        }


        function setFilesModel(){
            console.log(arguments[0])
            filesModel.clear();
            for(var i = 0; i < arguments[0].length; i++){
                var data = {"filePath": arguments[0][i]};
                filesModel.append(data);
                multiPics.currentIndex = 0;
            }
        }

        Component {
            id: imageDelegate


            Image {
                id:image
                width: grid.cellWidth - 10
                height: grid.cellHeight - 30
                fillMode: grid.fillMode
                asynchronous: true
                source: filePath
                MouseArea{
                    id:mouseArea
                    anchors.fill: parent
                    onClicked: {
                        //Settings.bookShelf.loadDir(":/book/")
                        console.log(image.height)
                        console.log(image.width)
                        console.log(grid.cellHeight)
                        console.log(grid.cellWidth)
                        wodeshuji.push(read)
                        view.interactive=false
                        bar.visible=false
                    }
                }
            }
        }
//        Component{
//            id:read
//            ReadPage{
//                anchors.fill: parent
//            }
//        }
    }


}
