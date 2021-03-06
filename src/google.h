#ifndef GOOGLE_H
#define GOOGLE_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QUrl>
#include <QUrlQuery>
#include <QJsonDocument>
#include <QJsonArray>
#include <QJsonValue>
#include <QTimer>

#include "abstract_translator.h"
#include "language.h"

class Google : public AbstractTranslator {
private:
    QUrl m_url;
    Languages m_langs;
    QNetworkAccessManager *m_qnam = nullptr;

    QString getAbbrLng(QString lng);
    QUrlQuery buildQuery(QString str);
    void jsonDecode(QByteArray data);

public:
    explicit Google(QObject *parent = nullptr);
    ~Google();

    QString name()         const final;
    QList<QString> langs() const final;

    // translate translated str from the language parsed in `SetFrom`
    // to the string parsed in `SetTo`.
    void translate() final;

private slots:
    void httpFinished(QNetworkReply *reply);
};

#endif // Google_H
