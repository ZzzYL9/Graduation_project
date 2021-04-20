import QtQuick 2.0
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3
import QtQuick.Window 2.12
import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2
import QtQuick.Controls.Styles 1.4
import "../../common"
import "../../Item/homepage"
import "../../Item/bookshelf"
import "../../"

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

    function setmodel_2(){
        for(var i=0;i<Settings.bookShelf.booksCount;i++){
            if(i==1){
                Settings.bookShelf.booksAt(i).isbookshelf=true
            }else if(i==2){
                Settings.bookShelf.booksAt(i).isbookshelf=true
            }/*else if(i==2){
                Settings.bookShelf.booksAt(i).isbookshelf=true
            }*/
        }
        for(var i=0;i<Settings.bookShelf.booksCount;i++){
            if(Settings.bookShelf.booksAt(i).isbookshelf==true){
//                console.log(Settings.bookShelf.booksAt(i).index)
                console.log(Settings.bookShelf.booksAt(i).bookName)
//                console.log(Settings.bookShelf.booksAt(i).image)
                var data2 = {"bookindex":Settings.bookShelf.booksAt(i).index,"bookname":Settings.bookShelf.booksAt(i).bookName,"image":Settings.bookShelf.booksAt(i).image, "bookdes":Settings.bookShelf.booksAt(i).bookDes };
                listmodel_2.append(data2)
//                listmodel_3.append(data3)
//                listmodel_4.append(data4)
//                listmodel_5.append(data5)
            }

        }

    }

    ListModel{//畅爽都市
        id:listmodel_2
    }
    ListModel{//热血玄幻
        id:listmodel_3
    }
    ListModel{//缥缈修仙
        id:listmodel_4
    }
    ListModel{//历史军事
        id:listmodel_5
    }


    Timer{
        interval: 500;
        running: true;
        repeat: false
        onTriggered: {
            setmodel_2()
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
            height:4  //高
            z:2
            color:"#e6e6e6" //颜色
        }





        Rectangle{
            id:content
//            anchors.top: sort_tbar.bottom
            width:rootwindow.width
            height: rootwindow.height-sort_tbar.height
//            color: "red"

            Column{
                Rectangle{
                    id:sort
                    width: sort_tbar.width
                    height: sort_tbar.height
                    z:2
                    Row{
                        spacing: 20
                        anchors.centerIn: parent
                        Text {
                            text: qsTr("畅爽都市")
                            font.bold: true
                            font.pixelSize: 15
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    swipView.currentIndex=0
                                    console.log("向服务器发送“热度榜”并获取json文件")
                                    console.log("解析json文件并存入listmodel中")
                                    console.log("显示返回结果")
                                }
                            }
                        }
                        Text {
                            text: qsTr("热血玄幻")
                            font.bold: true
                            font.pixelSize: 15
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    swipView.currentIndex=1
                                    console.log("向服务器发送“新书榜”并获取json文件")
                                    console.log("解析json文件并存入listmodel中")
                                    console.log("显示返回结果")
                                }
                            }
                        }
                        Text {
                            text: qsTr("缥缈修仙")
                            font.bold: true
                            font.pixelSize: 15
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    swipView.currentIndex=2
                                    console.log("向服务器发送“口碑榜”并获取json文件")
                                    console.log("解析json文件并存入listmodel中")
                                    console.log("显示返回结果")
                                }
                            }
                        }
                        Text {
                            text: qsTr("历史军事")
                            font.bold: true
                            font.pixelSize: 15
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    swipView.currentIndex=3
                                    console.log("向服务器发送“影视原著”并获取json文件")
                                    console.log("解析json文件并存入listmodel中")
                                    console.log("显示返回结果")
                                }
                            }
                        }
                    }
                }
                Rectangle{//模拟线段
                    width:rootwindow.width //长
                    height:4  //高
                    z:2
                    color:"#e6e6e6" //颜色
                }

                SwipeView {
                    clip: true
                    width: sort_tbar.width
                    height: content.height
                    id: swipView;
                        Loader{
                            sourceComponent: redu
                        }
                        Loader{
                            sourceComponent: xinshu
                        }
                        Loader{
                            sourceComponent: koubei
                        }
                        Loader{
                            sourceComponent: yuanzhu
                        }
                }
                Component{
                    id:redu
                    Rectangle{
                        width: sort_tbar.width
                        height: content.height-sort.height-8

                        ListView{
                            id:bookshelfview_1;
//                            anchors.fill: parent;
//                            anchors.left: parent.left
//                            anchors.leftMargin: 10
                            width: content.width;
                            height: content.height;
        //                    cellWidth: 1/3*rootwindow.width;
        //                    cellHeight: 1/4*(rootwindow.height-basebar.height);

                            //model: Settings.bookShelf.books;
                            model:listmodel_2
                            delegate:

                                Sort_ShelfItem{
                                width: bookshelfview_1.width*1/4;
                                height: bookshelfview_1.height*1/6;
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
                Component{
                    id:xinshu
                    Rectangle{
                        width: sort_tbar.width
                        height: content.height-sort.height-8

                        ListView{
                            id:bookshelfview_2;
//                            anchors.fill: parent;
//                            anchors.left: parent.left
//                            anchors.leftMargin: 10
                            width: content.width;
                            height: content.height;
        //                    cellWidth: 1/3*rootwindow.width;
        //                    cellHeight: 1/4*(rootwindow.height-basebar.height);

                            //model: Settings.bookShelf.books;
                            model:listmodel_2
                            delegate:

                                Sort_ShelfItem{
                                width: bookshelfview_2.width*1/4;
                                height: bookshelfview_2.height*1/6;
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
                Component{
                    id:koubei
                    Rectangle{
                        width: sort_tbar.width
                        height: content.height-sort.height-8

                        ListView{
                            anchors.fill: parent
                            anchors.leftMargin: 20
                            spacing:10
                            model:ListBookModel{}

                            delegate: Component{


                                Column{
                                    Row{
                                        id:controw
                                        spacing: 10
                                        Rectangle{
                                           width:imgsize
                                           height:imgsize
                                           MouseArea{
                                               anchors.fill: parent

                                               onClicked: {
                                                   console.log("向服务器发送书籍信息并获取书籍文件")
                                                   console.log("进入阅读界面")
                                               }
                                           }

                                           Image{
                                               id:_bookimage
                                               height: parent.width
                                               width: parent.height
                                               source: bookimage
                                           }
                                        }
                                        Column{
                                           Text {//书籍名字
                                               id: _bookname
                                               text: bookname
                                               font.bold: true
                                               font.pixelSize: 15
                                           }
                                           Text {//书籍简介
                                               id: _bookdesc
                                               width:bookdesc_wid
                                               height: bookdesc_hei
                                               text: bookdesc
    //                                           font.bold: true
                                               font.pixelSize: 14
                                               wrapMode: Text.WordWrap
                                           }
                                       }
                                    }
                                    Rectangle{//模拟线段
                                        width:rootwindow.width-40 //长
                                        height:4  //高
                                        color:"#e6e6e6" //颜色
                                    }
                                }
                            }
                        }
                    }
                }
                Component{
                    id:yuanzhu
                    Rectangle{
                        width: sort_tbar.width
                        height: content.height-sort.height-8

                        ListView{
                            anchors.fill: parent
                            anchors.leftMargin: 20
                            spacing:10
                            model:ListBookModel{}

                            delegate: Component{


                                Column{
                                    Row{
                                        id:controw
                                        spacing: 10
                                        Rectangle{
                                           width:imgsize
                                           height:imgsize
                                           MouseArea{
                                               anchors.fill: parent

                                               onClicked: {
                                                   console.log("向服务器发送书籍信息并获取书籍文件")
                                                   console.log("进入阅读界面")
                                               }
                                           }

                                           Image{
                                               id:_bookimage
                                               height: parent.width
                                               width: parent.height
                                               source: bookimage
                                           }
                                        }
                                        Column{
                                           Text {//书籍名字
                                               id: _bookname
                                               text: bookname
                                               font.bold: true
                                               font.pixelSize: 15
                                           }
                                           Text {//书籍简介
                                               id: _bookdesc
                                               width:bookdesc_wid
                                               height: bookdesc_hei
                                               text: bookdesc
    //                                           font.bold: true
                                               font.pixelSize: 14
                                               wrapMode: Text.WordWrap
                                           }
                                       }
                                    }
                                    Rectangle{//模拟线段
                                        width:rootwindow.width-40 //长
                                        height:4  //高
                                        color:"#e6e6e6" //颜色
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
