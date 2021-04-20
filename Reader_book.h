#ifndef Reader_Book_H
#define Reader_Book_H

#include <QObject>
#include<QList>
#include<QString>
#include<QQmlListProperty>
#include<Book_chapter.h>
class Reader_Book : public QObject
{
    Q_OBJECT
public:
    explicit Reader_Book(QObject *parent = nullptr);
    Q_PROPERTY(QString bookName READ bookName WRITE setBookName NOTIFY bookNameChanged)
    Q_PROPERTY(QString bookDes READ bookDes WRITE setBookDes NOTIFY bookDesChanged)
    Q_PROPERTY(QString image READ image WRITE setimage NOTIFY imageChanged)
    Q_PROPERTY(int currentPage READ currentPage WRITE setCurrentPage NOTIFY currentPageChanged)
    Q_PROPERTY(int currentChart READ currentChart WRITE setCurrentChart NOTIFY currentChartChanged)
    Q_PROPERTY(int index READ index WRITE setindex NOTIFY indexChanged)
    Q_PROPERTY(bool isbookshelf READ bookshelf WRITE setbookshelf NOTIFY bookshelfChanged)
    Q_PROPERTY(QString bookSource READ bookSource WRITE setBookSource NOTIFY bookSourceChanged)
    Q_PROPERTY(QString content READ content WRITE setContent NOTIFY contentChanged)
    Q_PROPERTY(QQmlListProperty<Book_chapter>charts READ charts CONSTANT )
    Q_PROPERTY(unsigned int lastVisitedTime READ lastVisitedTime WRITE setLastVisitedTime NOTIFY lastVisitedTimeChanged)
public:

   int currentPage()const;
   int currentChart()const;
   int index()const;
   QString bookName()const;
   QString bookDes()const; //简介
   QString bookSource()const;
   QString content()const;
   QString image()const;
   bool bookshelf()const;
   void setBookName(QString path);
   void setBookDes(QString des);
   void setindex(int index);
   void setimage(QString path);
   void setCurrentPage(int page);
   void setCurrentChart(int chart);
   void setBookSource(QString booksource);
   void setContent(QString content);
   void setbookshelf(bool is);

   unsigned int lastVisitedTime();
   void setLastVisitedTime(unsigned int lastTime);


signals:
     void bookNameChanged(QString name);
     void bookDesChanged(QString des);
     void currentPageChanged(int page);
     void currentChartChanged(int Chart);
     void bookSourceChanged(QString booksource);
     void contentChanged(QString content);
     void indexChanged(int index);
     void bookshelfChanged(bool is);
     void imageChanged(QString path);
       void lastVisitedTimeChanged();
public slots:
     QQmlListProperty<Book_chapter> charts();
     int chartCount();
     void appendChart(Book_chapter*chapter);
     Book_chapter *chartAt(int index);
     void clearCharts();

public:
    static void appendChart(QQmlListProperty<Book_chapter>*,Book_chapter *chapter);
    static int chartCount(QQmlListProperty<Book_chapter>*);
    static Book_chapter * chartAt(QQmlListProperty<Book_chapter>*,int index);
    static void clearCharts(QQmlListProperty<Book_chapter>*);


private:
    QString m_image;
    QString m_name;
    int m_index;
    int m_currentPage;  //当前页
    int m_currentChart;//当前章节
    int font_acount;//字节总数
    QString m_bookSource;//当前目录
    QString m_content;//当前文章内容
    QString m_des; //简介
    bool m_isbookshelf;
    QList<Book_chapter*>m_charts;//不同的章节
    unsigned int last_visted_time;//上一次访问时间  根据上一次访问时间进行排序 此处使用时间戳
};

#endif // Reader_Book_H
