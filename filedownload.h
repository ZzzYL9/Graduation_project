#ifndef FILEDOWNLOAD_H
#define FILEDOWNLOAD_H

#include <QObject>

class QDir;
class QUrl;
class QFile;
class QNetworkReply;
class QNetworkAccessManager;

class FileDownload : public QObject
{
    Q_OBJECT
public:
    virtual ~FileDownload(){}
    FileDownload(const FileDownload&)=delete;
    FileDownload& operator=(const FileDownload&)=delete;

    static FileDownload& get_instance(){
        static FileDownload instance;
        return instance;
    }
    static void setAddrPort(QString addr, int port){
        QString newAddrPort= QString("%1:%2").arg(addr).arg(port).append("/");
        addrport = newAddrPort;
    }
    static void setLocaladdr(QString addr){
        if(addr.at(addr.size()-1) != '/'){
            addr.append('/');
        }
        localaddr = addr;

    }

    bool downLoad(QString &url,  bool wait = false);
    static QString addrport;
    static QString localaddr;
private:
    FileDownload();
};

#endif // FILEDOWNLOAD_H
