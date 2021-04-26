import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import "../savejson.js" as Data
import "../"



Page{
    id: loginPage
    title: "Login"

    signal loginSucceeded
    property string time: Qt.formatDateTime(new Date(), "yyyy-MM-dd  hh-mm-ss  dddd")
    property bool hasname:false
    property bool password:false
    property bool zhuce: false
    property var userimage: ""
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
    Rectangle {
        id: rectangle1
        height: 50
        color: "#ffffff"
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        MouseArea{
            anchors.fill: parent
        }
        Text {
            x: 295
            y: 0
            width: 50
            height: 26
            text: qsTr("登录")
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 12
        }
        Button {
            flat: true
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.top: parent.top
            anchors.topMargin: 10
            height: 30
            width: 30
            Image {
                anchors.fill: parent
                source: "qrc:/Images/common/back1.png"
            }
            onClicked:{

                swipeview.interactive=true
                basebar.visible=true
                wodepage.clear()
            }
        }
        Rectangle {
            width: parent.width
            height: 1
            color: "#d2d2d2"
            anchors.bottom:parent.bottom
        }
    }


    Rectangle {
//        color: "blue"
        id: loginForm
        width: loginPage.width*3/4
        height: loginPage.height/2
        anchors.top: rectangle1.bottom
//        anchors.margins: 40
        anchors.centerIn: parent
//        anchors.horizontalCenter: parent.horizontalCenter
//        anchors.verticalCenter: parent.verticalCenter

        Text {
            y: 34
            text: "登录"
            font.pixelSize: loginPage.width*3/160+loginPage.height*3/200
            anchors.bottom: txtUsername.top
            anchors.bottomMargin: loginPage.height/100
            anchors.horizontalCenter: parent.horizontalCenter
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
//                anchors.horizontalCenterOffset: 0
//                flat: false
//                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    //Get.down_load()
                    time=Qt.formatDateTime(new Date(), "yyyy-MM-dd  hh-mm-ss  dddd")

                    fileio.setSource("/root/read/qReader/View/data.json")
                    var json = JSON.parse(fileio.text)
                    models.clear()
                    var count = json.TEXT.length
                    if(txtUsername.text.toString()==""||txtPassword.text.toString()==""){
                        reminder.text="请输入用户名和密码!"
                        console.debug("Please enter the name and password!")
                    }else{
                        for (var i in json.TEXT) {

                            if(json.TEXT[ i ].name==txtUsername.text){
                                hasname = true
                                if(txtPassword.text==json.TEXT[ i ].password){
                                    password = true
                                }
                            }
                            fileio.setSource("/root/read/qReader/View/data.json")
                            var t = json.TEXT[ i ];
                            models.append( t );
                        }
                    }

                    var data = {
                        "name":txtUsername.text,
                        "password":txtPassword.text,
                        "time":time
                    }

                    if(hasname == true&&password == true){
                        console.debug("Login Successful!")
                        models.append(data)
                    }else if((hasname == false)&&txtUsername.text.toString()!=""){

                        zhuce=true
                        console.debug("Creat login Successful!")
                        models.append(data)
                    }else if(hasname == true&&password == false){
                        reminder.text="密码错误!"
                        console.debug("Password error!")
                    }

                    var res = Data.serialize(models);
                    fileio.text = res;

                    if((hasname == true&&password == true)||zhuce==true){
                        wodepage.onlogin=true
                        wodepage.userimage="qrc:/Images/my/headimg.png"
                        wodepage.username=txtUsername.text.toString()
                        swipeview.interactive=true
                        basebar.visible=true
                        wodepage.clear()
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
//                anchors.horizontalCenterOffset: 0
//                flat: false
//                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {

                }
            }



            ListModel{
                id:models
            }


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
        Button {
                id:reminder
                text: ""
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0
                anchors.horizontalCenterOffset: 0
                flat: true
                anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}
