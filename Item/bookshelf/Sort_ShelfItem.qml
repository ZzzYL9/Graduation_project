import QtQuick 2.13
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
            source: image
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
                font.pointSize: 10
                font.bold: true
            }
        }

        Rectangle{
            id:bookAuthorR
//            color: "pink"
            width: parent.width
            height: 20
            anchors.left: bookNameR.right
            anchors.leftMargin: 80
            Text {
                id: author
                text: "作者:"+book_author
                font.pointSize: 8
            }
        }

        Rectangle{
//            color: "blue"
            anchors.top: bookNameR.bottom
            anchors.left: delegate.right
            anchors.leftMargin: 10
            anchors.topMargin: 8
            width: 3.8*parent.width
            height: 7/8*parent.width
            Text {
                id: des
                color: "black"
                anchors.fill: parent
                verticalAlignment: TextInput.AlignVCenter
                horizontalAlignment: TextInput.AlignHCenter
                leftPadding: 5 //QtQuick 2.13 间隔
                rightPadding: 5
                text: qsTr(book_des)
//                    lineHeight: Text.ProportionalHeight //设置行间距
                lineHeight: 1 //行间距比例 最大 1
                wrapMode: Text.WordWrap //换行
                //elide 省略模式 wrap 换行模式
                //contentWidth 手动设置字体显示的宽与高
                font.pixelSize: 15
                fontSizeMode: Text.Fit //固定 Text 显示大小->字体自动变化的模式选中还有几种看文档
                minimumPixelSize: 10 //设置自动变化最小字体大小
            }
        }

        MouseArea{
            anchors.fill: parent;
            hoverEnabled: true;
            onClicked: {
//                openSource(index);
//                console.log(index)

                openSource(Settings.bookShelf.currentBook)
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
