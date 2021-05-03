import QtQuick 2.0
import QtQuick.Dialogs 1.3
import "../../"
import "../../View/savejson.js" as Data

Rectangle{
    radius: 10
    id:root;
    signal openSource();
    color: "transparent";
    property var book_name_: ""

    Rectangle{
        id:delegate;
        width:  parent.width-1.5/5*parent.width;
        height: parent.height-1.5/5.0*parent.height;
        anchors.bottom: parent.bottom;
        anchors.leftMargin: 40;
        focus: true;
        border.width: 2
        border.color: "#eeeeee";
        radius: 5;

        Image {
            id:book_image
            width: parent.width;
            height: parent.height;
            anchors.fill:parent;
            anchors.margins: 5
            source: image
//            source: "/run/media/root/759b8514-9f40-4637-bd8f-4200833df628/final_design/ReadClient-master/book/万界大起点/万界大起点.jpg"
//            source: "../../book/" + bookname + "/" + bookname + ".jpg";
//            source: "qrc"+image
        }

        Rectangle{
            color: "transparent"
            width: parent.width;
            height: 20
            anchors.top: book_image.bottom
            anchors.topMargin: 10
            Text {
                id: book_name
                text: bookname
                anchors.centerIn: parent
                font.bold: true
            }
        }

        MouseArea{
            anchors.fill: parent;
            hoverEnabled: true;
            onPressAndHold: {
                console.log(bookname)
                book_name_=bookname
                myMsgbox.visible=true
            }
            onClicked: {
//                openSource(index);
//                console.log(index)
                openSource(bookindex)
            }
            onEntered: {
                delegate.width=root.width-1/3*parent.width;
                delegate.height=root.height-1/3.0*parent.height;
                delegate.border.color="gold";
            }
            onExited: {
                delegate.width=root.width-2/5*parent.width;
                delegate.height=root.height-2/5.0*parent.height;
                delegate.border.color="#eeeeee";
            }
        }

    }
    MessageDialog{
       id:myMsgbox
       standardButtons: StandardButton.Yes | StandardButton.No
       modality: Qt.ApplicationModal
       title: "提示"
       text:"确认删除该书籍吗？"
       onYes:
       {
            del_shelf()
            Settings.flush=true
       }
    }

    ListModel{
        id:user_books
    }

    function del_shelf(){
        user_books.clear()
        fileio.setSource(user_book_path+Settings.user_name_global+".json")
        var json = JSON.parse(fileio.text)
        var count = json.BOOKS.length
        var content
        for(var i in json.BOOKS){
            var user_books_shelf
            if(json.BOOKS[i].book_name===book_name_){
                content = json.BOOKS[i]
                user_books_shelf={"user":content.user,"book_index":content.book_index,"type_num":content.type_num,"type_name":content.type_name,"book_path":content.book_path,"book_name":content.book_name,"book_img_path":content.book_img_path,"book_des":content.book_des,"book_author":content.book_author,"is_bookshelf":"1"}
                user_books.append(user_books_shelf)
            }else{
                content = json.BOOKS[i]
                user_books_shelf={"user":content.user,"book_index":content.book_index,"type_num":content.type_num,"type_name":content.type_name,"book_path":content.book_path,"book_name":content.book_name,"book_img_path":content.book_img_path,"book_des":content.book_des,"book_author":content.book_author,"is_bookshelf":content.is_bookshelf}
                user_books.append(user_books_shelf)
            }

        }
        fileio.setSource(user_book_path+Settings.user_name_global+".json")
        var res = Data.setbooks(user_books)
        fileio.text = res;
    }
}
