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

    ListModel{
        id:listmodel
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
                    text: qsTr("经典名著")
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
                            text: qsTr("热读榜")
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
                            text: qsTr("新书榜")
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
                            text: qsTr("口碑榜")
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
                            text: qsTr("影视原著")
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
                    id:xinshu
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
