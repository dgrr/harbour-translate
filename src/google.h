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

#include <QDebug>

#include "abstract_translator.h"

static const ConvTable GoogleLngTable[] = {
    {QString("es"), QString("Spanish")},
    {QString("en"), QString("English")}
};

class Google : public AbstractTranslator {
    Q_OBJECT
private:
    QUrl m_url;
    QNetworkAccessManager *m_qnam = nullptr;

    QUrlQuery buildQuery(QString str);
    void jsonDecode(QByteArray data);

public:
    explicit Google(QObject *parent = nullptr);
    ~Google();

    QString name() const final;

    // translate translated str from the language parsed in `SetFrom`
    // to the string parsed in `SetTo`.
    void translate() final;

private slots:
    void httpFinished(QNetworkReply *reply);

signals:
    void nameChanged(const QString &name);
};

#endif // Google_H
