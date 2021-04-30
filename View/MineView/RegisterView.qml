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
import "../savejson.js" as Data

Rectangle{
    id:regR
    anchors.fill: parent

    property var user_path: "/run/media/root/759b8514-9f40-4637-bd8f-4200833df628/final_design/ReadClient-master/JSON/users.json"
    property var user_shelf_path: "/run/media/root/759b8514-9f40-4637-bd8f-4200833df628/final_design/ReadClient-master/JSON/"
    property bool exist_name: false

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
                    wodepage.pop()
                }
            }
        }
    }
    Rectangle {
//        color: "blue"
        id: regForm
        width: regR.width*3/4
        height: regR.height/2
        anchors.top: sort_tbar.bottom
        anchors.centerIn: parent

        MouseArea{
            anchors.fill: parent
        }

        Text {
            y: 34
            text: "注册"
            font.pixelSize: regR.width*3/160+regR.height*3/200
            anchors.bottom: txtUsername.top
            anchors.bottomMargin: regR.height/100
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
            text: qsTr("注册")
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 30
            anchors.left: parent.left
            anchors.leftMargin: 100
            width: regR.width/4
            height: 38.4
            onClicked: {
                register(user_path)
            }
        }

        Text {
            text: qsTr("帐号")
            anchors.rightMargin: 10
            anchors.verticalCenter: txtUsername.verticalCenter
            anchors.right: txtUsername.left
            font.pixelSize: regR.width*3/160+regR.height*3/200
        }

        TextField {
            id: txtUsername
            width: regR.width/2
            height: regR.height/15
            anchors.topMargin: 60
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.rightMargin: regR.width/16
        }

        Text {
            text: qsTr("密码")
            anchors.rightMargin: 10
            anchors.verticalCenter: txtPassword.verticalCenter
            anchors.right: txtPassword.left
            font.pixelSize: regR.width*3/160+regR.height*3/200
        }

        TextField {
            id: txtPassword
            width: regR.width/2
            height: regR.height/15
            anchors.topMargin: 10
            anchors.top: txtUsername.bottom
            anchors.right: parent.right
            anchors.rightMargin: regR.width/16
            echoMode: TextInput.Password
        }
    }

    ListModel{
        id:user_info_list_write
    }

    function register(user_path){
        //Get.down_load()
        fileio.setSource(user_path)
        var json = JSON.parse(fileio.text)
        var count = json.USER.length
        if(txtUsername.text.toString()==""||txtPassword.text.toString()==""){
            message.text="请输入用户名和密码!"
            mesT.running=true
            console.debug("Please enter the name and password!")
        }else{
            for (var i in json.USER) {
                if(json.USER[ i ].user_name===txtUsername.text.toString()){
                    //检查用户名是否存在
                    exist_name = true
                    message.text="用户名已存在!"
                    mesT.running=true
                    break
                }else
                    exist_name = false

                //先提前读取json文件中所有用户信息，避免下次存储被覆盖
                var content = json.USER[i]
                var data_user = {"user_name":content.user_name,"user_psw":content.user_psw,"user_shelf_path":content.user_shelf_path,"user_read_history":content.user_read_history,"user_note":content.user_note,"user_info":content.user_info}
                user_info_list_write.append(data_user)
            }
            //如果用户不存在，则新添加一个用户到users.json文件中，
            //然后再创建一个以用户名为名称的json文件保存用户书架信息
            if(!exist_name){

                var path = user_shelf_path+txtUsername.text.toString()+".json"
                var data = {"user_name":txtUsername.text.toString(),"user_psw":txtPassword.text.toString(),"user_shelf_path":path,"user_read_history":"0","user_note":"0","user_info":"0"}
                user_info_list_write.append(data)
                fileio.setSource(user_path)
                var res = Data.setuser(user_info_list_write)
                fileio.text = res;

                wodepage.pop()
            }

        }
    }
}
