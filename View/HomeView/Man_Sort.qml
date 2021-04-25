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
        fileio.setSource("/run/media/root/759b8514-9f40-4637-bd8f-4200833df628/final_design/ReadClient-master/JSON/books.json")
        var json = JSON.parse(fileio.text)
//            bookinfo.clear()
        var count = json.BOOKS.length
        var data
        for (var i in json.BOOKS) {
            var content = json.BOOKS[ i ];
            //如果type_num = 0:畅爽都市，1：热血玄幻 2：缥缈修仙，3：历史军事
            if(parseInt(content.type_num) === 0){
                data = {"bookindex":parseInt(content.book_index),"bookname":content.book_name,"image":content.book_img_path, "book_path":content.book_path, "book_author":content.book_author, "book_des":String(content.book_des) };
                listmodel_2.append(data)
            }else if(parseInt(content.type_num) === 1){
                data = {"bookindex":parseInt(content.book_index),"bookname":content.book_name,"image":content.book_img_path, "book_path":content.book_path, "book_author":content.book_author, "book_des":String(content.book_des) };
                listmodel_3.append(data)
            }else if(parseInt(content.type_num) === 2){
                data = {"bookindex":parseInt(content.book_index),"bookname":content.book_name,"image":content.book_img_path, "book_path":content.book_path, "book_author":content.book_author, "book_des":String(content.book_des) };
                listmodel_4.append(data)
            }else if(parseInt(content.type_num) === 3){
                data = {"bookindex":parseInt(content.book_index),"bookname":content.book_name,"image":content.book_img_path, "book_path":content.book_path, "book_author":content.book_author, "book_des":String(content.book_des) };
                listmodel_5.append(data)
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
                            model:listmodel_3
                            delegate:

                                Sort_ShelfItem{
                                width: bookshelfview_2.width*1/4;
                                height: bookshelfview_2.height*1/6;
                                onOpenSource: {

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
                            id:bookshelfview_2;
//                            anchors.fill: parent;
//                            anchors.left: parent.left
//                            anchors.leftMargin: 10
                            width: content.width;
                            height: content.height;
        //                    cellWidth: 1/3*rootwindow.width;
        //                    cellHeight: 1/4*(rootwindow.height-basebar.height);

                            //model: Settings.bookShelf.books;
                            model:listmodel_4
                            delegate:

                                Sort_ShelfItem{
                                width: bookshelfview_2.width*1/4;
                                height: bookshelfview_2.height*1/6;
                                onOpenSource: {

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
                    id:yuanzhu
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
                            model:listmodel_5
                            delegate:

                                Sort_ShelfItem{
                                width: bookshelfview_2.width*1/4;
                                height: bookshelfview_2.height*1/6;
                                onOpenSource: {

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
    }
}
