import QtQuick 2.0
import "../../"

Rectangle{
    radius: 10
    id:root;
    signal openSource();
    color: "transparent"

    Rectangle{
        id:delegate;
        width:  parent.width-1.5/7*parent.width;
        height: parent.height-1.5/7.0*parent.height;
        anchors.fill: parent
        anchors.margins: 15
        focus: true;
        border.width: 2
        border.color: "#eeeeee";
        radius: 5;

        Image {
            id:book_image
            width: parent.width;
            height: parent.height;
            anchors.fill:parent;
            anchors.margins: 1
            source: "../../Images/books_image/Bookshelf_image/" + bookname + ".jpg"
        }

        Rectangle{
            id:bookNameR
//            color: "red"
            width: parent.width;
            height: 20
            anchors.left: book_image.right
            anchors.leftMargin: 10
            Text {
                id: book_name
                text: bookname
//                anchors.centerIn: parent
                font.pointSize: 13
                font.bold: true
            }
        }

        Rectangle{
//            color: "blue"
            anchors.top: bookNameR.bottom
            anchors.left: delegate.right
            anchors.leftMargin: 10
            anchors.topMargin: 8
            width: 3.2*parent.width
            height: 7/8*parent.width
            Text {
                id: des
                text: bookdes
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
