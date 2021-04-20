 /*
    该代码显示目录 下面选项视图片段
    authos:rownh
    date:2019.8.28
*/
import QtQuick 2.4
import QtQuick.Window 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import "../savejson.js" as Data
import "../../"
Item {
    id: mainView
    property Component catalogs: catalogs;
    property Component thought: thought;
    property Component label: label;
    property var backColor;
    property var fontColor;
    property var catalogoModel;
    property int name: 1
    Component{
        id:catalogs;
        Rectangle{
            anchors.fill: parent;
            width: parent.width;
            height: parent.height;
            ListView{
                id:view
                width: parent.width;
                height: parent.height
                model: Settings.bookShelf.booksAt(Settings.bookShelf.currentBook).charts;
                delegate: Rectangle{
                    width: parent.width;
                    height: 50;
                    color: backColor;
                    Text {
                        anchors.fill: parent;
                        text: model.name
                        color:index===Settings.bookShelf.booksAt(Settings.bookShelf.currentBook).currentChart? "orange": fontColor
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                    }
                    MouseArea{
                        anchors.fill: parent;
                        onClicked: {
                           Settings.bookShelf.booksAt(Settings.bookShelf.currentBook).currentChart=index;
                           showCatalogs.visible=0
                        }
                    }
                    border.color: "#eeeeee";
                }


            }
        }
    }
    Component{
        id:thought;
        Rectangle{
            anchors.fill: parent;
            width: parent.width;
            height: parent.height;
            ListView{
                id:listview1
                width: parent.width;
                height: parent.height
                model:m
                delegate: Rectangle{
                    id:rectangle4
                    width: parent.width;
                    height: 50;
                    color: backColor;


                    Text{
                        id:txt
                        text:ttxt+".text.txt"
                        anchors.left: weizhi.right
                        anchors.leftMargin: 20
                    }

                    Text {
                        id: weizhi
                        text: "位置:"+ty
                    }
                    Text {
                        id: neirong
                        text: thetext
                        anchors.top: weizhi.bottom
                    }
                    border.color: "#eeeeee";
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            Settings.bookShelf.booksAt(Settings.bookShelf.currentBook).currentChart=ttxt;
                            views.contentY=ty-10
                            showCatalogs.visible=0
                        }
                    }
                    Button{
                        height: 30
                        width: 30
                        anchors.right: parent.right
                        anchors.top: parent.top
                        onClicked: {
                            m.remove(index)
                            for(var i = 0; i < m.count; i++){
                                var num=1
                                for(var x=0; x<i;x++){
                                    if(m.get(i).ty==m.get(x).ty){
                                        num=num+1
                                    }
                                }
                                m.setProperty(i,"num",num)
                            }
                            fileio.setSource("/root/read/qReader/View/note.json")
                            var res = Data.setnote(m);
                            fileio.text = res;

                        }
                    }
                }


            }
        }
    }
    Component{
        id:label;
        Rectangle{
            anchors.fill: parent;
            width: parent.width;
            height: parent.height;
            ListView{
                id:listview2
                width: parent.width;
                height: parent.height
                model:n
                delegate: Rectangle{
                    width: parent.width;
                    height: 50;
                    color: backColor;
                    Text{
                        id:txt
                        text:ttxt+".text.txt"
                        anchors.left: weizhi.right
                        anchors.leftMargin: 20
                    }

                    Text {
                        id: weizhi
                        text: "位置:"+ty
                    }
                    border.color: "#eeeeee";
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {

                            console.log(typeof name)
                            Settings.bookShelf.booksAt(Settings.bookShelf.currentBook).currentChart=ttxt ;
                            views.contentY=ty-10
                            showCatalogs.visible=0
                        }
                    }
                    Button{
                        height: 30
                        width: 30
                        anchors.right: parent.right
                        anchors.top: parent.top
                        onClicked: {
                             n.remove(index)

                        }
                    }
                }


            }
        }
    }
}





