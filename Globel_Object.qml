pragma Singleton
import QtQuick 2.0
import Settings 1.0
import BookShelf 1.0
QtObject{
    id:root;
    property var bookSetting: BookSetting{}
    property var bookShelf: BookShelf{
        currentBook: 0;
    }
    property var user_name_global:""
    property int is_log: 0

    property var btn_text: "加入书架(需登录使用)"
    property bool btn_enable: false
    property bool flush: false
}
