#ifndef YANDEX_H
#define YANDEX_H

#include <QObject>
#include <QUrl>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>

#include "abstract_translator.h"
#include "language.h"

class Yandex : public AbstractTranslator {
private:
    QUrl m_url;
    Languages m_langs;
    QNetworkAccessManager *m_qnam = nullptr;
public:
    explicit Yandex(QObject *parent = nullptr);
    ~Yandex();

    QString name() const final;
    QList<QString> langs() const final;

    void translate() final;

private slots:
    void httpFinished(QNetworkReply *reply);
};

#endif // YANDEX_H
