import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import "../savejson.js" as Data
import "../../Item/bookshelf/readview"
import "../../Popup"
import"../../"
Rectangle{
    id:root;
    property string bookstr:"";
    property string bookname:"";
    property int chart:0;
    property int type: -1
    property var footColor: "#301818"
    property var maincolor: "transparent"
    anchors.fill: parent;
    
    /*C++注册的章节对象
    booksSource:小说的地址
    currengePage:小说的当前页数
    charts:小说每一章的信息
    currentChart:当前章数
    */
    
    property int yi: -1
    property string ttext: ""
    property bool na: false
    property bool ma: false
    property int positionstarts: -1
    property int positionends: -1
    property int positiony: -1
    property var current_book: ""
    property var text_content: ""


    Timer{
        interval: 1;
        running: true;
        repeat: false
        onTriggered: {

            fileio.setSource("/run/media/root/759b8514-9f40-4637-bd8f-4200833df628/final_design/ReadClient-master/JSON/note.json")
            var json = JSON.parse(fileio.text)
            m.clear()
            var count = json.NOTE.length
            for (var i in json.NOTE) {
                var t = json.NOTE[ i ];
                if(t.users===Settings.user_name_global&&t.book===current_book){
                    t.ty=parseInt(t.ty);
                    t.num=parseInt(t.num);
                    t.ttxt=parseInt(t.ttxt);
                    t.positionstart=parseInt(t.positionstart);
                    t.positionend=parseInt(t.positionend);
                    m.append( t );
                }
            }
        }
    }

    Keys.onPressed: {
        if(event.key==Qt.Key_Back){
            event.accepted=true;
            bookstack.clear()
            topBars.visible=true;
            basebar.visible=true;
            swipeview.interactive=true;
        }
    }

    function modelappend(){
        var num=1
        for(var i = 0; i < arguments[0].count; i++){
            if(arguments[3]==arguments[0].get(i).ty){
                num=num+1
            }
        }

        console.log("存储笔记:"+current_book)
        //存储数据——————————————————————————
        var data = {"users":Settings.user_name_global,"current_book":current_book,"thetext":arguments[1],"thesource":"../../Images/readview/biji.png","num":num,"ty":arguments[3],"bookimage":"qrc"+Settings.bookShelf.booksAt(Settings.bookShelf.currentBook).image,"positionstart":arguments[2],"positionend":arguments[4],"ttxt":Settings.bookShelf.booksAt(Settings.bookShelf.currentBook).currentChart};
        m.append(data)
        fileio.setSource("/run/media/root/759b8514-9f40-4637-bd8f-4200833df628/final_design/ReadClient-master/JSON/note.json")
        var res = Data.setnote(m);
        fileio.text = res;

            //multiPics.currentIndex = 0;
        }

    function modelnappend(){
        //for(var i = 0; i < arguments[0].count; i++){


        var data = {"book":Settings.bookShelf.currentBook,"thesource":"../../Images/readview/shuqian.png","positionstart":arguments[1],"positionend":arguments[3],"ty":arguments[2],"ttxt":Settings.bookShelf.booksAt(Settings.bookShelf.currentBook).currentChart};
        n.append(data)
            //multiPics.currentIndex = 0;
        //}

    }

    ListModel{
        id:m1
    }

    ListModel{
        id:m
        ListElement {
            users:"a"
            book:0
            thetext:"A"
            thesource: "../../Images/readview/biji.png"
            ty:20
            num:1
            bookimage:"qrc:/book/help/help.jpg"
            positionstart:44
            positionend:45
            ttxt:0
        }
        ListElement {
            users:"a"
            book:0
            thetext:"B"
            thesource: "../../Images/readview/biji.png"
            ty:130
            num:1
            bookimage:"qrc:/book/help/help.jpg"
            positionstart:138
            positionend:139
            ttxt:0
        }

        ListElement {
            users:"a"
            book:0
            thetext:"C"
            thesource: "../../Images/readview/biji.png"
            ty:130
            num:2
            bookimage:"qrc:/book/help/help.jpg"
            positionstart:136
            positionend:139
            ttxt:0
        }
    }
    ListModel{
        id:n
        ListElement {
            book:0
            thesource: "../../Images/readview/shuqian.png"
            ty:20
            positionstart:44
            positionend:45
            ttxt:0
        }

        ListElement {
            book:0
            thesource: "../../Images/readview/shuqian.png"
            ty:130
            positionstart:138
            positionend:139
            ttxt:0
        }
    }
    Popup{
        id:popup
        height: 100
        width: 300
        anchors.centerIn: parent
        onClosed: textedit.text=""
        TextField{
            id:textedit
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20
        }
        Button{
            id:tianjiabutton
            anchors.top: textedit.bottom
            height: 20
            width: parent.width/2-5
            text: qsTr("ok")
            onClicked: {
                ttext=textedit.text
                modelappend(m,ttext,positionstarts,positiony,positionends)
                popup.close()
                readerText.deselect()
                rectangle2.visible=false
                views.interactive=true
            }
        }
        Button{
            anchors.top: textedit.bottom
            anchors.left: tianjiabutton.right
            anchors.leftMargin: 10
            height: 20
            width: parent.width/2-5
            text: qsTr("close")
            onClicked: {
                popup.close()
                readerText.deselect()
                rectangle2.visible=false
                views.interactive=true
            }
        }
    }
    //页头
    Rectangle{
        id:fonter;
        width: parent.width;
        height: 15;
        color: Settings.bookSetting.back_Color;
        z:3
        Text {
            anchors.left: parent.left;
            anchors.margins: 2
            id: read
            text:qsTr(Settings.bookShelf.booksAt(Settings.bookShelf.currentBook).chartAt(Settings.bookShelf.booksAt(Settings.bookShelf.currentBook).currentChart).name)
            font.pixelSize:10
            color: Settings.bookSetting.font_Color
        }
    }
    //主体部分
    Rectangle{
        width: parent.width;
        height: parent.height-footer.height-fonter.height;
        anchors.top: fonter.bottom;
        color: Settings.bookSetting.back_Color
        property var state: "base";
        property bool refresh: state == "pulled" ? true : false

        states: [
               State {
                   name: "base"; when: views.contentY >= -120//listWorkSheet列表控件
               },
               State {
                   name: "pulled"; when: views.contentY < -120//listWorkSheet列表控件

               }
           ]
        Flickable {
            id: views
            contentX: width;
            contentHeight:root.height>readerText.height?root.height:readerText.height
            width: parent.width;
            height: parent.height;
            //contentY:(contentHeight-view.height)*jindu.value>0?(contentHeight-view.height)*jindu.value:0
            property var isSetting: 0
            onDragEnded: {
                console.log(views.contentY-readerText.height)
                if (views.contentY< -60) {
                        if(Settings.bookShelf.booksAt(Settings.bookShelf.currentBook).currentChart<1){

                        }
                        else{
                            Settings.bookShelf.booksAt(Settings.bookShelf.currentBook).currentChart--;
                            views.contentX=0;
                            views.contentY=0;
                        }
                    }
                else if(views.contentY-readerText.height>-500){
                    if(Settings.bookShelf.booksAt(Settings.bookShelf.currentBook).currentChart<Settings.bookShelf.booksAt(Settings.bookShelf.currentBook).chartCount()-1){
                        Settings.bookShelf.booksAt(Settings.bookShelf.currentBook).currentChart++;
                        views.contentX=0;
                        views.contentY=0;
                    }
                }
            }

            Keys.onUpPressed: scrollBar.decrease()
            Keys.onDownPressed: scrollBar.increase()
            ScrollBar.vertical: ScrollBar {
                      parent: views
                      anchors.top: views.top
                      anchors.right: views.right
                      anchors.bottom: views.bottom
            }

            Rectangle{
                width: parent.width;
                height: parent.height;
                color: maincolor;



                TextEdit {
                    id:readerText;
                    width: parent.width
                    height: contentHeight
                    readOnly: true;
                    selectByMouse: true
                    selectionColor: "#505050"
                    color: Settings.bookSetting.font_Color;
                    font.pixelSize: Settings.bookSetting.font_Size
                    text:Settings.bookShelf.booksAt(Settings.bookShelf.currentBook).chartAt(Settings.bookShelf.booksAt(Settings.bookShelf.currentBook).currentChart).str
                    wrapMode: Text.WrapAnywhere
                    onTextChanged: {
                        views.contentHeight=root.height>readerText.height? root.height:readerText.height;
                    }
                    onHeightChanged:{

                        for(var i = 0; i < n.count; i++){
                            n.setProperty(i,"ty",readerText.positionToRectangle(n.get(i).positionstart).y)
                        }
                        for(var i = 0; i < m.count; i++){
                            var num=1
                            m.setProperty(i,"ty",readerText.positionToRectangle(m.get(i).positionstart).y)
                            for(var x=0; x<i;x++){
                                if(m.get(i).ty==m.get(x).ty){
                                    num=num+1
                                }
                            }
                            m.setProperty(i,"num",num)
                        }
                    }

                    horizontalAlignment:Settings.bookSetting.alignment_method;
                    padding:20

                    MouseArea{
                        id:mousea
                        propagateComposedEvents: true
                        anchors.top: parent.top;
                        anchors.bottom: parent.bottom
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                        anchors.right: parent.right
                        anchors.rightMargin: 20
                        onPressed: {
                            mouse.accept=false
                        }
                        onPositionChanged: {
                            if(readerText.positionAt(mouseX,mouseY)==readerText.selectionEnd){
                                na=true
                            }
                            if(na==true){
                                views.interactive=false
                                readerText.select(readerText.selectionStart,readerText.positionAt(mouseX,mouseY))
                            }
                            if(readerText.positionAt(mouseX,mouseY)==readerText.selectionStart){
                                ma=true
                            }
                            if(ma==true){
                                views.interactive=false
                                readerText.select(readerText.positionAt(mouseX,mouseY),readerText.selectionEnd)
                            }
                        }

                        onReleased: {
                            rectangle2.visible=true
                            rectangle2.x=readerText.positionToRectangle(readerText.selectionEnd).x
                            rectangle2.y=readerText.positionToRectangle(readerText.selectionEnd).y+(readerText.height/readerText.lineCount)

                            positionstarts=readerText.selectionStart
                            positionends=readerText.selectionEnd
                            positiony=readerText.positionToRectangle(readerText.selectionStart).y
                            ma=false
                            na=false
                            views.interactive=true
                        }
                        onPressAndHold: {
                            if((readerText.selectionEnd-readerText.selectionStart)==0){
                                readerText.cursorPosition=readerText.positionAt(mouseX,mouseY)
                                if(readerText.cursorPosition==0){
                                    readerText.select(readerText.cursorPosition,readerText.cursorPosition+3)
                                }else{
                                    readerText.select(readerText.cursorPosition-2,readerText.cursorPosition+3)
                                }
                            }
                            //yi=mouseY
                            //popup.open()
                        }

                        onClicked: {
                            console.log(r.height)

                            if((readerText.selectionEnd-readerText.selectionStart)==0){
                                rectangle2.visible=false
                                if(footSetter.isBrightNess==1 && mouseY%root.height<root.height-showBrightNess.height){
                                    footSetter.isBrightNess=0;
                                }
                                else if(footSetter.isSetting==1&&  mouseY%root.height<root.height-showSettingBottom.height){
                                    footSetter.isSetting=0;
                                }
                                else if(views.isSetting==1 &&mouseY%root.height>fontSetter.height&&mouseY%root.height<root.height-footSetter.height){
                                    views.isSetting=0;
                                }
                                else if(footSetter.isCatalogView==1 && mouseX>showCatalogs.width){
                                    footSetter.isCatalogView=0;
                                }
                                else if(views.isSetting==0&& mouseX>width/2-width/5*1 && mouseX< width/2+width/5*1){
                                    views.isSetting=1;
                                    showFont.start();
                                    showFoot.start();
                                }
                            }else{
                                if(readerText.selectionStart>readerText.positionAt(mouseX,mouseY)||readerText.positionAt(mouseX,mouseY)>readerText.selectionEnd){
                                    readerText.deselect()
                                    rectangle2.visible=false
                                    views.interactive=true
                                }
                            }
                        }
                    }

                    Rectangle {
                        id: rectangle2
                        width: 100
                        height: 30
                        color: "#1d1d1d"
                        radius: 15
                        visible: false

                        Rectangle {
                            id: rectangle
                            width: 40
                            color: "#00000000"
                            anchors.leftMargin: 0
                            anchors.right: parent.horizontalCenter
                            anchors.rightMargin: 0
                            anchors.bottom: parent.bottom
                            anchors.left: parent.left
                            anchors.top: parent.top

                            Text {
                                id: element
                                color: "#ffffff"
                                text: qsTr("书签")
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.verticalCenter: parent.verticalCenter
                                font.pixelSize: 12
                                MouseArea{
                                    anchors.fill: parent
                                    onClicked: {
                                        modelnappend(n,positionstarts,positiony,positionends)
                                        readerText.deselect()
                                        rectangle2.visible=false
                                        views.interactive=true
                                    }
                                }
                            }
                        }

                        Rectangle {
                            id: rectangle3
                            width: 40
                            color: "#00000000"
                            anchors.rightMargin: 10
                            anchors.left: parent.horizontalCenter
                            anchors.leftMargin: 0
                            anchors.right: parent.right
                            anchors.bottom: parent.bottom
                            anchors.top: parent.top

                            Text {
                                id: element1
                                color: "#ffffff"
                                text: qsTr("笔记")
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.verticalCenter: parent.verticalCenter
                                font.pixelSize: 12
                                MouseArea{
                                    anchors.fill: parent
                                    onClicked: {
                                        popup.open()
                                    }
                                }
                            }
                        }

                    }

                }


                Repeater{
                    id:r
                    anchors.top: parent.top;
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    width: 20
                    model:n
                    delegate:
                        Image{
                            id:image
                            x:0
                            y:ty
                            visible: ttxt==Settings.bookShelf.booksAt(Settings.bookShelf.currentBook).currentChart ? true:false
                            height: 20
                            width: 20
                            source: thesource
                            anchors.left: parent.left
                            anchors.leftMargin: 0
                        }
                }
                Repeater{
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.right: parent.right
                    width: 20
                    model:m
                    delegate:
                        Image{
                            id:image1
                            height: 20
                            width: 20
                            y:ty
                            visible: ttxt==Settings.bookShelf.booksAt(Settings.bookShelf.currentBook).currentChart ? true:false
                            source: thesource
                            anchors.right: parent.right
                            anchors.rightMargin: 0
                            Text {
                                id: name
                                anchors.centerIn: parent
                                text: num
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    //textedit.text=thetext
                                    //popup.open()
                                    m1.clear()
                                    rectangle4.visible=true
                                    for(var i=0;i<m.count;i++){
                                        if(m.get(i).ty==image1.y){
                                            m1.append(m.get(i))
                                        }
                                    }
                                }
                            }
                        }

                }

            }
        }
    }
    Rectangle{
        id:footer;
        width: parent.width;
        height: 15;
        color: Settings.bookSetting.back_Color;
        anchors.bottom: root.bottom;
        Text {
            color:Settings.bookSetting.back_Color;
            anchors.left: parent.left;
            height: parent.height
            anchors.leftMargin: 5;
            id: currentRead;
            font.pixelSize: 10;
            font.italic: true;
            text: qsTr((Settings.bookShelf.booksAt(Settings.bookShelf.currentBook).currentPage/(Settings.bookShelf.booksAt(Settings.bookShelf.currentBook).chartCount()+0.0)).toString());
        }
        Rectangle{
            width: 50;
            height: parent.height;
            anchors.right: parent.right;
            anchors.rightMargin: 5;
            color: Settings.bookSetting.back_Color;
            Text{
                anchors.left: parent.left;
                text: Date().toString();
                color: Settings.bookSetting.font_Color;
                font.pixelSize: 10
            }

        }

    }
    //页头设置部分
    Rectangle{
        id:fontSetter;
        width: parent.width;
        height: 40;
        visible: views.isSetting;
        opacity: 0.9
        z:4;
        //anchors.top: parent.top;
        color: footColor
        Rectangle{
            width: parent.width-anchors.rightMargin-anchors.leftMargin;
            height: parent.height-anchors.topMargin-anchors.bottomMargin;
            anchors.top: parent.top;
            anchors.right: parent.right;
            anchors.left: parent.left;
            anchors.bottom: parent.bottom;
            anchors.bottomMargin: 10;
            anchors.topMargin: 10;
            anchors.rightMargin: 20;
            anchors.leftMargin: 20;
            color: "transparent";
            RowLayout{
                width: parent.width;
                height: parent.height;
                anchors.fill: parent;
                //左键头 表示返回
                Rectangle{
                    height: parent.height;
                    width: 20;
                    color: "transparent"
                    Image {
                        anchors.fill: parent;
                        source: "../../Images/readview/back.png"
                    }
                    MouseArea{
                        anchors.fill: parent;
                        onClicked: {
                            //root.visible=0;
                            //views.isSetting=0;
                            //当点击返回时，顶底部导航栏显示，swipeview滑动界面减去导航栏，并且swipeview可以滑动
                            Settings.bookShelf.clearBooks()
                            if(type==0){
                                bookstack.clear()
                                topBars.visible=true;
                                basebar.visible=true;
                                //swipeview.height=rootwindow.height - basebar.height;
                                swipeview.interactive=true;
                               //删除读取的内容----------------------
                            }else if(type==1){
                               homeview.pop()
                            }else{
                               mynotes.clear();
                            }




                        }
                    }
                }
                Rectangle{
                    width: 100;
                    height: parent.height;
                    color: "transparent";
                }
                Rectangle{
                    id:buyButton;
                    height: parent.height;
                    width: 40;
                    radius: 8;
                    color: "transparent"
                    Text {
                        anchors.fill: parent;
                        text: qsTr("购买")
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter;
                        color: "#FF4500"
                        font.pixelSize: 10;
                    }
                    border.color: "#FF4500"

                }
                Rectangle{
                    id:giftButton;
                       width: 25;
                       height: parent.height;
                       color: "transparent";
                       Image {
                           anchors.fill: parent;
                           source: "../../Images/readview/giftButton.png"
                       }
                }
                Rectangle{
                    id:headsetButton;
                       width: 25;
                       height: parent.height;
                       color: "transparent";
                       Image {
                           anchors.fill: parent;
                           source: "../../Images/readview/HeadsetButton.png"
                       }
                }
                Rectangle{
                    id:listButton;
                       width: 25;
                       height: parent.height;
                       color: "transparent";
                       Image {
                           anchors.fill: parent;
                           source: "../../Images/readview/listButton.png"
                       }
                }
            }

        }
        ParallelAnimation{
            id: showFont;
            PropertyAnimation{
                id: showFontY;
                target: fontSetter;
                from:root.height+footSetter.height;
                to:root.height-footSetter.height;
                duration: 1000
            }
            PropertyAnimation{
                id: showFontOpacy;
                target: fontSetter;
                property:"opacity";
                from:0
                to:0.9
                duration: 1000
            }
        }
    }
    //页脚设置部分
    Rectangle{
        id:footSetter;
        width: parent.width;
        height: 100;
        visible: views.isSetting;
        color: footColor;
        property var isCatalogView: 0       //目录是否显示
        property var isBrightNess: 0
        property var isNeight: 0
        property var isSetting: 0
        ColumnLayout{
            height: 50;
            width: parent.width;
            anchors.fill: parent;
            anchors.leftMargin: 20;
            anchors.rightMargin: 20;
            RowLayout{
                    id:process;
                    height: parent.height
                    width: parent.width;
                    spacing: (parent.width-50-slider.width-50)/2
                    Rectangle{
                        width: 50;
                        height: 20;
                        color: "transparent"
                        Text {
                            color: "white"
                            text: qsTr("上一章")
                        }
                        MouseArea{
                            anchors.fill: parent;
                            onClicked: {
                                if(Settings.bookShelf.booksAt(Settings.bookShelf.currentBook).currentChart<1){

                                }
                                else{
                                    Settings.bookShelf.booksAt(Settings.bookShelf.currentBook).currentChart--;
                                    views.contentX=0;
                                    views.contentY=0;
                                }


                            }
                        }
                    }
                    Rectangle{
                        id:slider;
                        height: 50;
                        width: parent.width-150
                        color: "transparent"
                        Slider{
                            anchors.fill: parent;
                            width: parent.width;
                            from:0;
                            to:Settings.bookShelf.booksAt(Settings.bookShelf.currentBook).chartCount()-1;
                            stepSize:1
                            value: Settings.bookShelf.booksAt(Settings.bookShelf.currentBook).currentChart;
                            onMoved: {
                                Settings.bookShelf.booksAt(Settings.bookShelf.currentBook).currentChart=value
                            }

                        }

                    }
                    Rectangle{
                        width: 50;
                        height: 20;
                        color: "transparent"
                        Text {
                            color:"white"
                            text: qsTr("下一章")

                        }
                        MouseArea{
                            anchors.fill: parent;
                            onClicked: {
                                if(Settings.bookShelf.booksAt(Settings.bookShelf.currentBook).currentChart<Settings.bookShelf.booksAt(Settings.bookShelf.currentBook).chartCount()-1){
                                    Settings.bookShelf.booksAt(Settings.bookShelf.currentBook).currentChart++;
                                    views.contentX=0;
                                    views.contentY=0;
                                }
                            }
                        }
                    }
            }
            RowLayout{
                // spacing:10;
                width: parent.width;
                height: parent.height
                spacing: (parent.width-catalog.width-brightness.width-nightModel.width-set.width)/3.0
                SettingButton{
                    id:catalog;
                    width: 30;
                    height: 40;
                    buttonText :qsTr("目录")
                    buttonIconPath:"../../Images/readview/catalog.png";
                    buttonBackColor: "transparent";
                    MouseArea{
                        anchors.fill: parent;
                        onClicked: {
                            showCatalogs.visible=1
                            showCatalogAnimation.start();
                            footSetter.isCatalogView=1;
                            views.isSetting=0;
                        }
                    }
                }
                SettingButton{
                    id:brightness
                    width: 30;
                    height: 40;
                    buttonText: qsTr("亮度")
                    buttonIconPath: "../../Images/readview/brightness.png"
                    buttonBackColor: "transparent"
                    MouseArea{
                        anchors.fill: parent;
                        onClicked: {
                            showBrightNessAnimation.start();
                            footSetter.isBrightNess=1;
                            views.isSetting=0;

                        }

                    }
                }
                SettingButton{
                    id:nightModel
                    width: 30;
                    height: 40;
                    buttonText: qsTr("夜间")
                    buttonIconPath: "../../Images/readview/nightmodel.png"
                    buttonBackColor: "transparent"
                    MouseArea{
                        anchors.fill: parent;
                        onClicked: {
                            footSetter.isNeight=!footSetter.isNeight;
                            nightModel.buttonIconPath=footSetter.isNeight?"../../Images/readview/nightmodel.png":"../../Images/readview/brightness.png"
                            maincolor=footSetter.isNeight?"#4F4F4F":"transparent"
                        }

                    }
                }
                SettingButton{
                    id:set;
                    width: 30;
                    height: 40;
                    buttonText: qsTr("设置")
                    buttonIconPath: "../../Images/readview/set.png"
                    buttonBackColor: "transparent"
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            footSetter.isSetting=!footSetter.isSetting;
                            showSettingBottomAnimation.start();
                            views.isSetting=0;
                        }
                    }
                }
            }
            ParallelAnimation{
                id:showFoot;
                PropertyAnimation{
                    id: showFootY;
                    target: footSetter;
                    property:"y";
                    from:root.height+footSetter.height;
                    to:root.height-footSetter.height;
                    duration: 1000
                }
                PropertyAnimation{
                    id: showFootOpacy;
                    target: footSetter;
                    property:"opacity";
                    from:0
                    to:0.9
                    duration: 1
                }
            }
           }
      }
    PopupCatalog{
        id:showCatalogs;
        height: parent.height;
        width: parent.width-1.0/5.0*parent.width
        x:-width;
        z:3;
        visible: footSetter.isCatalogView;
        opacity: 0;
        cataModel: Settings.bookShelf.booksAt(Settings.bookShelf.currentBook).charts
        backColor: Settings.bookSetting.back_Color;
        fontColor: Settings.bookSetting.font_Color;
        ParallelAnimation{
            id:showCatalogAnimation;
            PropertyAnimation{
                id: showCatalogX;
                target: showCatalogs;
                property:"x";
                from:-width;
                to:0;
                duration: 1000
            }
            PropertyAnimation{
                id: showCatalogOpacty;
                target: showCatalogs;
                property:"opacity";
                from:0
                to:0.9
                duration: 1000
            }
        }
    }
    BrightNess{
        id:showBrightNess;
        height: parent.height*1/4.0;
        width: parent.width;
        visible:footSetter.isBrightNess;
        color: footColor
        z:2;
        y:root.height+height;
        ParallelAnimation{
            id:showBrightNessAnimation;
            PropertyAnimation{
                target: showBrightNess ;
                property:"y";
                from:root.height+showBrightNess.height;
                to:root.height-showBrightNess.height;
                duration: 1000
            }
            PropertyAnimation{
                target: showCatalogs;
                property:"opacity";
                from:0
                to:0.9
                duration: 1000
            }
        }


    }
    SettingBottom{
        id:showSettingBottom;
        visible: footSetter.isSetting
        width: parent.width;
        backgroundColor:footColor
        height: 200;
        y:root.height+height;
        z:2;
        ParallelAnimation{
            id:showSettingBottomAnimation;
            PropertyAnimation{
                target: showSettingBottom ;
                property:"y";
                from:root.height+showSettingBottom.height;
                to:root.height-showSettingBottom.height;
                duration: 1000
            }
            PropertyAnimation{
                target: showSettingBottom;
                property:"opacity";
                from:0
                to:0.9
                duration: 1000
            }
        }
    }
    Rectangle{
        visible: false
        id:rectangle4
        height: parent.height/2
        width: parent.width
        anchors.bottom: parent.bottom

        color: "#d2d2d2"
        Button{
            height: 20
            width: 20
            anchors.right: parent.right
            anchors.rightMargin: 20
            Image{
                anchors.fill: parent
                anchors.centerIn: parent
                source:"qrc:/Images/readview/cha.png"
            }

            onClicked: {
                rectangle4.visible=false
                m1.clear()
            }
        }

        ListView{
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.top: parent.top
            anchors.topMargin: 20
            clip: true
            model: m1
            spacing:10
            delegate:
                Rectangle{
                width: rectangle4.width
                height: rectangle4.height/3
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        views.contentY=ty-50
                        readerText.select(positionstart,positionend)
                    }
                }

                Text {
                    height: parent.height/4
                    width: parent.width
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    anchors.top: parent.top
                    anchors.topMargin: 10
                    text: "用户:"+users
                    clip: true
                    id:use
                }
                Text {
                    id: neirong
                    height: parent.height*3/4-20
                    width: parent.width
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    anchors.topMargin: 10
                    anchors.top: use.bottom
                    clip: true
                    text:"内容:"+thetext
                }

            }
        }
    }
}
