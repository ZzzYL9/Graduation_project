import QtQuick 2.0
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3
import QtQuick.Window 2.12
import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2
import QtQuick.Controls.Styles 1.4
import "../../common"
import "../../Item/bookshelf"
import "../../"
import "../../View/readview"
import "../../Item/homepage"

StackView {
    property var bookdesc_wid: 5/8*rootwindow.width
    property var bookdesc_hei: imgsize.height
    property var imgsize: 1/4*rootwindow.width

    property alias sorttitle: sorttitle.text
    anchors.fill: parent

    Keys.onPressed: {
        if(event.key==Qt.Key_Back){
            event.accepted=true;
            basebar.visible = true
            searchBar.visible=true
            swipeview.interactive=true;
            homeview.clear()
        }
    }

    function setmodel_1(){
        for(var i=0;i<3;i++){
//        for(var i=0;i<Settings.bookShelf.booksCount;i++){
            if(i==0){
                Settings.bookShelf.booksAt(i).isbookshelf=true
            }/*else if(i==1){
                Settings.bookShelf.booksAt(i).isbookshelf=true
            }else if(i==2){
                Settings.bookShelf.booksAt(i).isbookshelf=true
            }*/
        }
        for(var i=0;i<3;i++){
            if(Settings.bookShelf.booksAt(i).isbookshelf==true){
//                console.log(Settings.bookShelf.booksAt(i).index)
                console.log(Settings.bookShelf.booksAt(i).bookName)
//                console.log(Settings.bookShelf.booksAt(i).image)
                var data = {"bookindex":Settings.bookShelf.booksAt(i).index,"bookname":Settings.bookShelf.booksAt(i).bookName,"image":Settings.bookShelf.booksAt(i).image};
                listmodel_1.append(data)
            }

        }

    }


    ListModel{
        id:listmodel_1
    }

    Timer{
        interval: 500;
        running: true;
        repeat: false
        onTriggered: {
            setmodel_1()
        }
    }

    Column{

        TopBars {
            id:sort_tbar
            height: 0.07*rootwindow.height
            width: rootwindow.width
            z:2
            RowLayout {
                anchors.fill: parent
                IconButton {
                    iconSource:"qrc:/Images/common/back.png"
                    onClicked:{

                        basebar.visible = true
                        searchBar.visible=true
                        //解除禁止滑动
                        swipeview.interactive=true;
                        homeview.clear()
                    }
                }
                Label {
                    id:sorttitle
//                    text: qsTr("经典名著")
                    font.bold: true
                    font.pixelSize:18
                    elide: Label.ElideRight
                    horizontalAlignment: Qt.AlignHCenter
                    verticalAlignment: Qt.AlignVCenter
                    Layout.fillWidth: true
                }
            }
        }
        Rectangle{//模拟线段
            width:rootwindow.width //长
            height:2  //高
            z:2
            color:"#e6e6e6" //颜色
        }

        Rectangle{
            id:content
//            anchors.top: sort_tbar.bottom
            width:rootwindow.width
            height: rootwindow.height-sort_tbar.height
            color: "red"

            Rectangle{//模拟线段
                width:rootwindow.width //长
                height:4  //高
                z:2
                color:"#e6e6e6" //颜色
            }

            //主编推荐
            Rectangle{
                id:zbtjR
//                color: "orange"
                height: 1/3*parent.height
                width: parent.width
                Rectangle{
                    Text {
                        id: zbtj
                        text: "主编推荐"
                        font.bold: true
                        font.pointSize: 14
                    }
                }
                GridView{
                    id:bookshelfview_1;
//                        anchors.fill: parent;
                    anchors.left: zbtjR.left
                    anchors.leftMargin: 2/13*cellWidth
                    width: parent.width;
                    height: parent.height;
                    cellWidth: 1/3*rootwindow.width;
                    cellHeight: 1/4*(rootwindow.height-basebar.height);

                    //model: Settings.bookShelf.books;
                    model:listmodel_1
                    delegate:

                        Book_ShelfItem{
                        width: bookshelfview_1.cellWidth;
                        height: bookshelfview_1.cellHeight;
                        onOpenSource: {

//                                    Settings.bookShelf.currentBook=bookindex;
//                                    Settings.bookShelf.booksAt(Settings.bookShelf.currentBook).currentChart=0
//                                    console.log("start")
//                                    console.log(Settings.bookShelf.booksAt(Settings.bookShelf.currentBook).chartAt(Settings.bookShelf.booksAt(Settings.bookShelf.currentBook).currentChart).str)
//                                    console.log("end")

//                                    bookstack.push(readview)
        //                        readview.visible=true;
                            //顶、底部导航隐藏
        //                    topBars.visible=false;
                            basebar.visible=false;
                            //界面高度增加
                            swipeview.height=rootwindow.height;
                            //禁止滑动
                            swipeview.interactive=false;

                        }
                    }
                }
            }

            Rectangle{//模拟线段
                id:line_2 //第二根线
                width:rootwindow.width //长
                height:6  //高
                z:2
                color:"#e6e6e6" //颜色
                anchors.top: zbtjR.bottom
            }

            //本期精品
            Rectangle{
                id: bqjpR
//                color: "pink"
                height: 1/3*parent.height
                width: parent.width
                anchors.top: line_2.bottom

                Rectangle{
                    Text {
                        id: bqjp
                        text: "本期精品"
                        font.bold: true
                        font.pointSize: 14
                    }
                }

                GridView{
                    id:bookshelfview_2;
//                        anchors.fill: parent;
                    anchors.left: bqjpR.left
                    anchors.leftMargin: 2/13*cellWidth
                    width: parent.width;
                    height: parent.height;
                    cellWidth: 1/3*rootwindow.width;
                    cellHeight: 1/4*(rootwindow.height-basebar.height);

                    //model: Settings.bookShelf.books;
                    model:listmodel_1
                    delegate:

                        Book_ShelfItem{
                        width: bookshelfview_2.cellWidth;
                        height: bookshelfview_2.cellHeight;
                        onOpenSource: {

//                                    Settings.bookShelf.currentBook=bookindex;
//                                    Settings.bookShelf.booksAt(Settings.bookShelf.currentBook).currentChart=0
//                                    console.log("start")
//                                    console.log(Settings.bookShelf.booksAt(Settings.bookShelf.currentBook).chartAt(Settings.bookShelf.booksAt(Settings.bookShelf.currentBook).currentChart).str)
//                                    console.log("end")

//                                    bookstack.push(readview)
        //                        readview.visible=true;
                            //顶、底部导航隐藏
        //                    topBars.visible=false;
                            basebar.visible=false;
                            //界面高度增加
                            swipeview.height=rootwindow.height;
                            //禁止滑动
                            swipeview.interactive=false;

                        }
                    }
                }

            }

            Rectangle{//模拟线段
                id: line_3
                width:rootwindow.width //长
                height:6 //高
                z:2
                color:"#e6e6e6" //颜色
                anchors.top: bqjpR.bottom
            }

            //重磅推荐
            Rectangle{
                id: zhongbangR
//                color: "white"
                height: 1/3*parent.height
                width: parent.width
                anchors.top: line_3.bottom

                Rectangle{
                    Text {
                        id: zhongbang
                        text: "重磅推荐"
                        font.bold: true
                        font.pointSize: 14
                    }
                }

                GridView{
                    id:bookshelfview_3;
//                        anchors.fill: parent;
                    anchors.left: zhongbangR.left
                    anchors.leftMargin: 2/13*cellWidth
                    width: parent.width;
                    height: parent.height;
                    cellWidth: 1/3*rootwindow.width;
                    cellHeight: 1/4*(rootwindow.height-basebar.height);

                    //model: Settings.bookShelf.books;
                    model:listmodel_1
                    delegate:

                        Book_ShelfItem{
                        width: bookshelfview_3.cellWidth;
                        height: bookshelfview_3.cellHeight;
                        onOpenSource: {

//                                    Settings.bookShelf.currentBook=bookindex;
//                                    Settings.bookShelf.booksAt(Settings.bookShelf.currentBook).currentChart=0
//                                    console.log("start")
//                                    console.log(Settings.bookShelf.booksAt(Settings.bookShelf.currentBook).chartAt(Settings.bookShelf.booksAt(Settings.bookShelf.currentBook).currentChart).str)
//                                    console.log("end")

//                                    bookstack.push(readview)
        //                        readview.visible=true;
                            //顶、底部导航隐藏
        //                    topBars.visible=false;
                            basebar.visible=false;
                            //界面高度增加
                            swipeview.height=rootwindow.height;
                            //禁止滑动
                            swipeview.interactive=false;

                        }
                    }
                }
            }


        }
    }
}
