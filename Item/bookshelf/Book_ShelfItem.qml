import QtQuick 2.0
import "../../"

Rectangle{
    radius: 10
    id:root;
    signal openSource();
    color: "transparent";

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
            source: "../../Images/books_image/Bookshelf_image/csds/" + bookname + ".jpg"
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
}
