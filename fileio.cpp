#include <QStandardPaths>
#include "fileio.h"

FileIO::FileIO(QObject *parent) : QObject(parent)
{

}

FileIO::~FileIO()
{

}

void FileIO::read()
{
    if(m_path.isEmpty()) {
        return;
    }

    QFile file(m_path.path());
    //QFile *file= new QFile;
    if(!file.exists()) {
        file.open(QIODevice::WriteOnly);
//        qWarning() << "Does not exits: " << m_path.toLocalFile();
        return;
    }
    if(file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        //file.open(QIODevice::ReadOnly | QIODevice::Text);
        QTextStream stream(&file);
        m_text = stream.readAll();
        emit textChanged(m_text);
        qDebug() << "Text has been successfully read!";
    }
}

void FileIO::write()
{
    if(m_source.isEmpty()) {
        qDebug() << "路径不存在";
        return;
    }

    qDebug() << "filename: " << m_path.fileName();
    qDebug() << "path: " << m_path.path();
    QFile file(m_path.path());
    file.setPermissions(QFile::WriteUser);
    file.setPermissions(QFile::WriteOwner);
    qDebug() << "File path: " << file.fileName();
    //if(file.open(QIODevice::WriteOnly | QIODevice::Append)) {
    if(file.open(QIODevice::WriteOnly)) {
        QTextStream stream(&file);
        stream << m_text;
        qDebug() << "Successfully write to file";
    } else {
        qWarning() << "Failed to write to the file: " << m_path;
    }
}

QString FileIO::source() const
{
    return m_source;
}

QString FileIO::text()
{
    qDebug() << "Going to read the text";
    read();
    return m_text;
}

void FileIO::setSource(QString source)
{
    if (m_source == source)
        return;
    m_source = source;
    emit sourceChanged(source);

    // at the same time update the path
    m_path = QUrl(source);
    qDebug() << m_path;

}

void FileIO::setText(QString text)
{
    if (m_text == text)
        return;

    m_text = text;
    write();
    emit textChanged(text);
}
