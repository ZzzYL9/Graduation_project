import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import "../"
import "../../"
import "../readview"

StackView{
    id: mynotes
    anchors.fill: parent

    Keys.onPressed: {
        if(event.key==Qt.Key_Back){
            event.accepted=true;
            swipeview.interactive=true
            basebar.visible=true
            wodepage.clear()
        }
    }
    Timer{
        interval: 500;
        running: true;
        repeat: false
        onTriggered: {
            fileio.setSource("/root/read/qReader/View/note.json")
            var json = JSON.parse(fileio.text)
            listmodel.clear()
            var count = json.NOTE.length
            for (var i in json.NOTE) {
                var t = json.NOTE[ i ];
                t.book=parseInt(t.book);
                t.ty=parseInt(t.ty);
                t.num=parseInt(t.num);
                t.ttxt=parseInt(t.ttxt);
                t.positionstart=parseInt(t.positionstart);
                t.positionend=parseInt(t.positionend);
                listmodel.append( t );
            }
        }
    }


    Rectangle {
        id: rectangle2
        height: 50
        color: "#ffffff"

        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0


        MouseArea{
            anchors.fill: parent
        }

        Text {
            width: 50
            height: 26
            text: qsTr("我的笔记")
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
                wodepage.clear();
            }
        }
        Rectangle {
            width: parent.width
            height: 1
            color: "#d2d2d2"
            anchors.bottom:parent.bottom
        }

//        Button {
//            id: button
//            width: 30
//            height: 30
//            anchors.top: parent.top
//            anchors.topMargin: 10
//            anchors.right: parent.right
//            anchors.rightMargin: 10
//            flat: true
//            Image {
//                anchors.fill: parent
//                source: "qrc:/Images/my/jia.png"
//            }
//            onClicked: {
//                push(notes)
//            }
//        }
    }

    Rectangle{
        id: rectangle
        anchors.top: parent.top
        anchors.topMargin: 50
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        color: "#f4f4f4"

        GridView {
            id: gridView
            anchors.fill: parent
            clip: true
            cellHeight: parent.height/3
            cellWidth: parent.width/2
            ScrollBar.vertical: ScrollBar { }
            property int fillMode: Image.PreserveAspectFit
            delegate:
                Rectangle{

                    id:rectangle3
                    width: gridView.cellWidth-10
                    height: gridView.cellHeight-10
                    color: "white"
                    Rectangle{
                        id:image
                        height: parent.height-60
                        width: height*2/3
                        anchors.left: parent.left
                        anchors.leftMargin: 5
                        anchors.top: parent.top
                        anchors.topMargin: 5
                        Image{
                            source: bookimage
                            height: parent.height
                            width: parent.width
                            asynchronous: true
                            fillMode: gridView.fillMode
                        }

                    }


                    Text {
                        id: thetexts
                        font.pixelSize: 12
                        font.family: "方正楷体_GBK"
                        height: parent.height/4-20
                        width: parent.width-image.width-20
                        elide: Text.ElideRight
                        anchors.top: parent.top
                        anchors.topMargin: 20
                        anchors.left: image.right
                        anchors.leftMargin: 5
                        wrapMode: Text.WrapAnywhere
                        clip: true
                        text: "用户："+users
                    }
                    Text {
                        id: neirong
                        font.pixelSize: 12
                        font.family: "方正楷体_GBK"
                        height: parent.height*3/4-20
                        width: parent.width-image.width-20
                        elide: Text.ElideRight
                        anchors.top: thetexts.bottom
                        anchors.topMargin: 0
                        anchors.left: image.right
                        anchors.leftMargin: 5
                        wrapMode: Text.WrapAnywhere
                        clip: true
                        text: "内容："+thetext
                    }

                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            Settings.bookShelf.currentBook=book;
                            Settings.bookShelf.booksAt(Settings.bookShelf.currentBook).currentChart=ttxt
                            mynotes.push(read)
                        }
                    }
            }
            model: ListModel {
                id:listmodel
            }
        }
    }
    Component{
        id:read
        ReaderView{
            width: rootwindow.width;
            height: rootwindow.height;
        }
    }

}

