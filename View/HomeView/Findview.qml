import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Window 2.2
import QtQuick.Layouts 1.0
import "../"
import "../../"

StackView{
    id: wodeshuji
    anchors.fill: parent
    property string f: "help"

    Keys.onPressed: {
        if(event.key==Qt.Key_Back){
            event.accepted=true;
            searchBar.visible=true
            swipeview.interactive=true
            basebar.visible=true
            homeview.clear()
        }
    }
    function setmodel(){
        for(var i=0;i<Settings.bookShelf.booksCount;i++){
            if(f==Settings.bookShelf.booksAt(i).bookName){
                var data = {"bookindex":Settings.bookShelf.booksAt(i).index,"bookname":Settings.bookShelf.booksAt(i).bookName,"image":Settings.bookShelf.booksAt(i).image};
                listmodel.append(data)
            }
        }

    }
    ListModel{
        id:listmodel
    }

    Timer{
        interval: 500;
        running: true;
        repeat: false
        onTriggered: {
            setmodel()
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
            text: qsTr("搜索")
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

                searchBar.visible=true
                swipeview.interactive=true
                basebar.visible=true
                homeview.clear()
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
        anchors.top: parent.top
        anchors.topMargin: 50
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        MouseArea{
            anchors.fill: parent
        }

        GridView{
            id:grid
            width: parent.width
            height: parent.height
            cellHeight: rectangle.height/3
            cellWidth: rectangle.width/3
            model: listmodel
            clip: true
            property int fillMode: Image.PreserveAspectFit
            delegate: Rectangle{
                width: rectangle.width/3-10
                height: rectangle.height/3-20
                Image {
                    id: book
                    width: parent.width
                    height: parent.height-10
                    fillMode: grid.fillMode
                    source: "qrc"+image
                }
                Text {
                    id: name
                    width: contentWidth
                    height: 10
                    anchors.top: book.bottom
                    text: bookname
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }
    }


}
