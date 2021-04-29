import QtQuick 2.0
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3
import QtQuick.Window 2.12
import QtQuick.Controls.Styles 1.4
import "../../common"
import "../../Item/bookshelf"
import "../../"
import "../../View/readview"
import "../../Item/homepage"

Rectangle {
    id:jx_page
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

    function getRandomNum(Min,Max){
        var Range = Max - Min;
        var rand = Math.random();
        return(Min + Math.round(rand*Range));
    }

    //利用生成随机数，随机显示书籍
    function setmodel_JX(){
        fileio.setSource("/run/media/root/759b8514-9f40-4637-bd8f-4200833df628/final_design/ReadClient-master/JSON/books.json")
        var json = JSON.parse(fileio.text);
//            bookinfo.clear()
        var count = json.BOOKS.length;
        var num = 0;

        var content = json.BOOKS[ getRandomNum(0,5) ];
        var data_1 =   {"bookindex":parseInt(content.book_index),"bookname":content.book_name,"image":content.book_img_path,"book_author":content.book_author, "book_path":content.book_path,"book_type":content.type_name,"book_des":content.book_des,"book_path":content.book_path};
        listmodel_1.append(data_1);

        content = json.BOOKS[ getRandomNum(6,10) ];
        data_1 =   {"bookindex":parseInt(content.book_index),"bookname":content.book_name,"image":content.book_img_path,"book_author":content.book_author, "book_path":content.book_path,"book_type":content.type_name,"book_des":content.book_des,"book_path":content.book_path};
        listmodel_2.append(data_1);

        content = json.BOOKS[ getRandomNum(11,15) ];
        data_1 =   {"bookindex":parseInt(content.book_index),"bookname":content.book_name,"image":content.book_img_path,"book_author":content.book_author, "book_path":content.book_path,"book_type":content.type_name,"book_des":content.book_des,"book_path":content.book_path};
        listmodel_3.append(data_1);

        content = json.BOOKS[ getRandomNum(16,20) ];
        data_1 =   {"bookindex":parseInt(content.book_index),"bookname":content.book_name,"image":content.book_img_path,"book_author":content.book_author, "book_path":content.book_path,"book_type":content.type_name,"book_des":content.book_des,"book_path":content.book_path};
        listmodel_1.append(data_1);

        content = json.BOOKS[ getRandomNum(21,25) ];
        data_1 =   {"bookindex":parseInt(content.book_index),"bookname":content.book_name,"image":content.book_img_path,"book_author":content.book_author, "book_path":content.book_path,"book_type":content.type_name,"book_des":content.book_des,"book_path":content.book_path};
        listmodel_2.append(data_1);

        content = json.BOOKS[ getRandomNum(26,30) ];
        data_1 =   {"bookindex":parseInt(content.book_index),"bookname":content.book_name,"image":content.book_img_path,"book_author":content.book_author, "book_path":content.book_path,"book_type":content.type_name,"book_des":content.book_des,"book_path":content.book_path};
        listmodel_3.append(data_1);

        content = json.BOOKS[ getRandomNum(31,35) ];
        data_1 =   {"bookindex":parseInt(content.book_index),"bookname":content.book_name,"image":content.book_img_path,"book_author":content.book_author, "book_path":content.book_path,"book_type":content.type_name,"book_des":content.book_des,"book_path":content.book_path};
        listmodel_1.append(data_1);

        content = json.BOOKS[ getRandomNum(36,39) ];
        data_1 =   {"bookindex":parseInt(content.book_index),"bookname":content.book_name,"image":content.book_img_path,"book_author":content.book_author, "book_path":content.book_path,"book_type":content.type_name,"book_des":content.book_des,"book_path":content.book_path};
        listmodel_2.append(data_1);

        content = json.BOOKS[ getRandomNum(0,39) ];
        data_1 =   {"bookindex":parseInt(content.book_index),"bookname":content.book_name,"image":content.book_img_path,"book_author":content.book_author, "book_path":content.book_path,"book_type":content.type_name,"book_des":content.book_des,"book_path":content.book_path};
        listmodel_3.append(data_1);
    }




    ListModel{
        id:listmodel_1
    }
    ListModel{
        id:listmodel_2
    }
    ListModel{
        id:listmodel_3
    }

    Timer{
        interval: 500;
        running: true;
        repeat: false
        onTriggered: {
            setmodel_JX()
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
                            load_page(0,bookname,book_author,book_type,book_des,image,book_path,bookindex)
                            console.log(bookindex)
                            console.log(bookname)
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
                    model:listmodel_2
                    delegate:

                        Book_ShelfItem{
                        width: bookshelfview_2.cellWidth;
                        height: bookshelfview_2.cellHeight;
                        onOpenSource: {
                            load_page(0,bookname,book_author,book_type,book_des,image,book_path,bookindex)
                            console.log(bookindex)
                            console.log(bookname)

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
                    model:listmodel_3
                    delegate:

                        Book_ShelfItem{
                        width: bookshelfview_3.cellWidth;
                        height: bookshelfview_3.cellHeight;
                        onOpenSource: {
                            load_page(0,bookname,book_author,book_type,book_des,image,book_path,bookindex)
                            console.log(bookindex)
                            console.log(bookname)

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


    Component{
        id:book_info
        Book_Info{
            width: rootwindow.width
            height: rootwindow.height
            z:2
        }
    }
    function load_page(page,name,author,type,des,image,book_path,book_index){
        switch(page){
        case 0:
            homeview.push(book_info,{book_name:name,book_author:author,book_type:type,book_des:des,img_path: image,book_path:book_path,book_index:book_index});
            break;
        }
    }
}
