import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import "../savejson.js" as Data
import "../"
import "../../common"
import "../../Item/bookshelf"
import "../../"
import "../../View/readview"
import "../../Item/homepage"


Page{
    id: loginPage
    title: "Login"

    signal loginSucceeded
    property string time: Qt.formatDateTime(new Date(), "yyyy-MM-dd  hh-mm-ss  dddd")
    property bool hasname:false
    property bool password:false
    property bool zhuce: false
    property var userimage: ""
    property var user_path: "/run/media/root/759b8514-9f40-4637-bd8f-4200833df628/final_design/ReadClient-master/JSON/users.json"
    //property bool userLoggedIn: true
    anchors.fill: parent

    Keys.onPressed: {
        if(event.key==Qt.Key_Back){
            event.accepted=true;
            swipeview.interactive=true
            basebar.visible=true
            wodepage.clear()
        }
    }
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
                    swipeview.interactive=true
                    basebar.visible=true
                    wodepage.clear()
                }
            }
        }
    }

    Rectangle {
//        color: "blue"
        id: loginForm
        width: loginPage.width*3/4
        height: loginPage.height/2
        anchors.top: sort_tbar.bottom
        anchors.centerIn: parent

        Text {
            y: 34
            text: "登录"
            font.pixelSize: loginPage.width*3/160+loginPage.height*3/200
            anchors.bottom: txtUsername.top
            anchors.bottomMargin: loginPage.height/100
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            id:message
            y: 34
            text: ""
            font.pixelSize: loginPage.width*3/160+loginPage.height*3/200
            anchors.top: txtPassword.bottom
            anchors.topMargin: loginPage.height/100
            anchors.horizontalCenter: parent.horizontalCenter
        }

        //设置定时器，提示信息之后一段时间，提示消失
        Timer{
            id:mesT
            interval: 1500;
            running: false;
            repeat: false
            onTriggered: {
                message.text=""
            }
        }

        Button {
            id: login_Btn
            text: qsTr("登录")
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 30
            anchors.left: parent.left
            anchors.leftMargin: 50
//                anchors.centerIn: parent
            width: loginPage.width/4
            height: 38.4
            onClicked: {

                fileio.setSource(user_path)
                var json = JSON.parse(fileio.text)
                var count = json.USER.length
                if(txtUsername.text.toString()==""||txtPassword.text.toString()==""){
                    message.text="请输入用户名和密码!"
                    mesT.running=true
                    console.debug("Please enter the name and password!")
                }else{
                    for(var i in json.USER){
                        if(json.USER[i].user_name===txtUsername.text.toString()&&json.USER[i].user_psw===txtPassword.text.toString()){
                            //登录成功之后，读取该用户的书架json文件
                            //如果没有的话就创建一个

                            fileio.setSource(json.USER[i].user_shelf_path)
//                            var user_shelf = JSON.parse(fileio.text)

                            wodepage.onlogin=true
                            wodepage.userimage="qrc:/Images/my/headimg.png"
                            wodepage.username=txtUsername.text.toString()
                            swipeview.interactive=true
                            basebar.visible=true
                            wodepage.clear()
                        }else{
                            message.text="用户名或密码错误!!"
                            mesT.running=true
                            console.debug("Please enter the name and password!")
                        }
                    }
                }
            }
        }


        Button {
            text: qsTr("注册")
            anchors.left: login_Btn.right
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 30
            anchors.leftMargin: 40
            width: loginPage.width/4
            height: 38.4
            onClicked: {
                wodepage.push(regview)
            }
        }

        Component{
            id:regview

            RegisterView{

            }
        }

//        ListModel{
//            id:models
//        }

        Text {
            text: qsTr("帐号")
            anchors.rightMargin: 10
            anchors.verticalCenter: txtUsername.verticalCenter
            anchors.right: txtUsername.left
            font.pixelSize: loginPage.width*3/160+loginPage.height*3/200
        }

        TextField {
            id: txtUsername
            width: loginPage.width/2
            height: loginPage.height/15
            anchors.topMargin: 60
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.rightMargin: loginPage.width/16
        }

        Text {
            text: qsTr("密码")
            anchors.rightMargin: 10
            anchors.verticalCenter: txtPassword.verticalCenter
            anchors.right: txtPassword.left
            font.pixelSize: loginPage.width*3/160+loginPage.height*3/200
        }

        TextField {
            id: txtPassword
            width: loginPage.width/2
            height: loginPage.height/15
            anchors.topMargin: 10
            anchors.top: txtUsername.bottom
            anchors.right: parent.right
            anchors.rightMargin: loginPage.width/16
            echoMode: TextInput.Password

        }
    }
}
