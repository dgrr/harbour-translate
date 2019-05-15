#ifndef DEEPL_H
#define DEEPL_H

#include <QObject>

#include <QObject>
#include <QUrl>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>

#include "abstract_translator.h"
#include "language.h"

class Deepl : public AbstractTranslator {
private:
    QUrl m_url;
    Languages m_langs;
    QNetworkAccessManager *m_qnam = nullptr;
public:
    explicit Deepl(QObject *parent = nullptr);
    ~Deepl();

    QString name() const final;
    QList<QString> langs() const final;

    void translate() final;

private slots:
    void httpFinished(QNetworkReply *reply);
};

#endif // DEEPL_H
