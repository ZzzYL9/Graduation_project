import QtQuick 2.0
import QtQuick.Controls 1.4
import "../common"
import "../Item/bookshelf"
import "../"
import "../View/readview"

//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//书籍读取定位，读取图片
StackView{
    id:bookstack
    width: rootwindow.width
    height:rootwindow.height


    // Settings是全局变量，这里读取的，在分类中也会显示
    function setmodel(){
        for(var i=0;i<Settings.bookShelf.booksCount;i++){
            if(i==0){
                Settings.bookShelf.booksAt(i).isbookshelf=true
            }else if(i==1){
                Settings.bookShelf.booksAt(i).isbookshelf=true
            }else if(i==2){
                Settings.bookShelf.booksAt(i).isbookshelf=true
            }
        }
        for(var i=0;i<Settings.bookShelf.booksCount;i++){
            if(Settings.bookShelf.booksAt(i).isbookshelf==true){
//                console.log(Settings.bookShelf.booksAt(i).index)
//                console.log(Settings.bookShelf.booksAt(i).bookName)
//                console.log(Settings.bookShelf.booksAt(i).image)
                var data = {"bookindex":Settings.bookShelf.booksAt(i).index,"bookname":Settings.bookShelf.booksAt(i).bookName,"image":Settings.bookShelf.booksAt(i).image};
                listmodel.append(data)
            }

        }

    }
    ListModel{
        id:listmodel
    }

    //点击书城按钮后，经过一定时间后显示书籍
    Timer{
        interval: 500;
        running: true;
        repeat: false
        onTriggered: {
            Settings.bookShelf.loadDir("/run/media/root/759b8514-9f40-4637-bd8f-4200833df628/final_design/ReadClient-master/book/畅爽都市/")
            setmodel()
        }
    }


    Rectangle{
        id:bookshelf
        color: "#CCCCCC"
        anchors.fill: parent
        Image {
                id: rocket
                fillMode: Image.TileHorizontally
//                    smooth: true
                width: rootwindow.width
                source: 'qrc:/Images/shelf/background.jpg'
        }

        TopBars{
            id: topBars
            height: 0.07*rootwindow.height
            width: rootwindow.width
            text: qsTr("我的书架")
            z: 2

            IconButton {
                id: searchButton
                anchors.right: addButton.left
                anchors.rightMargin: 16
                anchors.verticalCenter: parent.verticalCenter
                iconSource: "qrc:/Images/shelf/search.png"
                onClicked: {
                    console.log(Settings.bookShelf.booksAt())
                }
            }
            IconButton {
                id: addButton
                anchors.right: parent.right
                anchors.rightMargin: 16
                anchors.verticalCenter: parent.verticalCenter
                iconSource: "qrc:/Images/shelf/add.png"
                onClicked: {
                    addbtn.addbtnrec.visible=false
                    addbtn.addmenu.open()
                }
            }
        }

        AddButton{
            id:addbtn
            x:addButton.x-80
            y:addButton.y

        }

        GridView{
            id:bookshelfview;
//                anchors.fill: parent;
            anchors.left: bookshelf.left
            anchors.leftMargin: 2/13*cellWidth
            width: parent.width;
            height: parent.height;
            cellWidth: 1/3*rootwindow.width;
            cellHeight: 1/3*(rootwindow.height-basebar.height);

            //model: Settings.bookShelf.books;
            model:listmodel
            delegate:

                Book_ShelfItem{
                width: bookshelfview.cellWidth;
                height: bookshelfview.cellHeight;
                onOpenSource: {

                    Settings.bookShelf.currentBook=bookindex-2;
                    console.log(bookindex);
                    Settings.bookShelf.booksAt(Settings.bookShelf.currentBook).currentChart=0
                    console.log("start")
                    console.log(Settings.bookShelf.booksAt(Settings.bookShelf.currentBook).chartAt(Settings.bookShelf.booksAt(Settings.bookShelf.currentBook).currentChart).str)
                    console.log("end")

                    bookstack.push(readview)
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

    Component {
            id: readview
            ReaderView {
                visible: false;
                //anchors.fill: parent
               width: rootwindow.width;
               height: rootwindow.height;
               type:0
               bookname:""

            }
        }
}
