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

Rectangle{
    id:book_infoR
    width:rootwindow.width
    height: rootwindow.height
    MouseArea{
         anchors.fill:parent
    }

//    property alias book_info_image: book_info_image
    property var img_path: ""
    property var book_name: ""
    property var book_author: ""
    property var book_type: ""
    property var book_des: ""
    property var book_path: ""
    property int bookindex: 1

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
                        homeview.pop()
//                        basebar.visible = true
//                        searchBar.visible=true
                        //解除禁止滑动
//                        swipeview.interactive=true;
//                        book_infoR.clear()
                    }
                }

            }
        }

        Rectangle{
            id: top_halfR
//            color:"blue"
            width: rootwindow.width
            height: 0.4*rootwindow.height

            Rectangle{
                id:b_info
                width: 0.5*rootwindow.width
                height: 0.8*parent.height
                Rectangle{
                    id:b_name
                    width:parent.width
                    height: 1/3*parent.height
                    color: "red"
                    Text {
                        id: b_name_text
                        text: book_name
                        font.bold: true
                        font.pointSize: 16
                    }
                }
                Rectangle{
                    id:b_author
                    width:parent.width
                    height: 1/3*parent.height
                    color: "pink"
                    anchors.top: b_name.bottom
                    Text {
                        id: b_author_text
                        text: "作者："+book_author
                        font.pointSize: 14
                    }
                }
                Rectangle{
                    id:b_type
                    width:parent.width
                    height: 1/3*parent.height
                    color: "orange"
                    anchors.top:b_author.bottom
                    Text {
                        id: b_type_text
                        text: "类型："+"["+book_type+"]"
                        font.pointSize: 12
                    }
                }
            }

            Rectangle{
                id:b_img
                anchors.left: b_info.right
                width: 0.5*rootwindow.width
                height: 0.8*parent.height
                Image {
                    id:book_info_image
                    anchors.fill:parent;
                    source: img_path
                }
            }



        }
        Rectangle{//模拟线段
//                anchors.bottom: gridviewrec.top
            width:rootwindow.width //长
            height:4  //高
            color:"#e6e6e6" //颜色
        }
        Rectangle{
            id: bottom_halfR
//            color:"pink"
            width: rootwindow.width
            height: 0.4*rootwindow.height

            Rectangle{
                id:b_des
                width: 0.8*parent.width
                height: 0.6*parent.height
                anchors.top: parent.top
                anchors.topMargin: 20
                anchors.left: parent.left
                anchors.leftMargin: 10
                color: "white"

                Text {
                    id: b_des_text
                    text: "  简介："+book_des
                    font.bold: true
                    font.pointSize: 11
                }
            }
        }

        Rectangle{//模拟线段
//                anchors.bottom: gridviewrec.top
            width:rootwindow.width //长
            height:4  //高
            color:"#e6e6e6" //颜色
        }

        Rectangle{
            id:bottom_bar
            width: rootwindow.width
            height: 0.13*rootwindow.height
            color: "blue"



            Button{
                id:shelf_Btn
                width: 1/2*parent.width
                height: parent.height
                Text{
                    text: qsTr("加入书架")
                    font.bold: true
                    font.pointSize: 14
                    anchors.centerIn: parent
                }
            }
            Button{
                id:read_Btn
                anchors.left: shelf_Btn.right
                width: 1/2*parent.width
                height: parent.height
                Text{
                    text: qsTr("立即阅读")
                    font.bold: true
                    font.pointSize: 14
                    anchors.centerIn: parent
                }

                onClicked: {
                    console.log(book_path+book_name)
                    Settings.bookShelf.loadBook(book_path+book_name,book_name,bookindex)
                    Settings.bookShelf.currentBook=bookindex;
                    Settings.bookShelf.booksAt(Settings.bookShelf.currentBook).currentChart=0
                    homeview.push(readview,{type:1})
                }
            }
        }
    }
    Component {
            id: readview
            ReaderView {
//                visible: false;
                //anchors.fill: parent
               width: rootwindow.width;
               height: rootwindow.height;
               type:0
               bookname:""

            }
    }

}
