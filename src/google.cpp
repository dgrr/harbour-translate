#include "google.h"

Google::Google(QObject *parent) : AbstractTranslator(parent) {
    m_url = QUrl("https://translate.google.com/translate_a/single");
    m_qnam = new QNetworkAccessManager();
    connect(m_qnam, &QNetworkAccessManager::finished, this,  &Google::httpFinished);

    m_langs.append({
        new Language { "es", "Spanish" },
        new Language { "en", "English" }
    });
}

Google::~Google() {
    delete m_qnam;
}

QString Google::name() const {
    return "Google";
}

void Google::translate() {
    QUrl url(m_url);
    url.setQuery(buildQuery(m_text));

    QNetworkRequest req(url);
    // TODO: Use a user agent list
    req.setHeader(QNetworkRequest::UserAgentHeader, "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.75 Safari/537.36");

    QNetworkReply *reply = m_qnam->get(req);
    QTimer timer;
    timer.setSingleShot(true);

    connect(&timer, &QTimer::timeout,         reply, &QNetworkReply::abort);
    connect(reply,  &QNetworkReply::finished, this,  &AbstractTranslator::finished);

    timer.start(20000); // 20 seconds
}

QString Google::getAbbrLng(QString lang) {
    for (Language *s : m_langs) {
        if (s->name() == lang) {
            return s->abbr();
        }
    }
    return "en"; // TODO: Change default.
}

QUrlQuery Google::buildQuery(QString str) {
    QString to = getAbbrLng(m_to);
    QString from = getAbbrLng(m_from);
    QUrlQuery q = QUrlQuery();

    q.addQueryItem(
        QString("client"), QString("gtx")
    );
    q.addQueryItem(
        QString("dt"), QString("at")
    );
    q.addQueryItem(
        QString("dt"), QString("bd")
    );
    q.addQueryItem(
        QString("dt"), QString("ex")
    );
    q.addQueryItem(
        QString("dt"), QString("ld")
    );
    q.addQueryItem(
        QString("dt"), QString("md")
    );
    q.addQueryItem(
        QString("dt"), QString("qca")
    );
    q.addQueryItem(
        QString("dt"), QString("rw")
    );
    q.addQueryItem(
        QString("dt"), QString("rm")
    );
    q.addQueryItem(
        QString("dt"), QString("ss")
    );
    q.addQueryItem(
        QString("dt"), QString("t")
    );
    q.addQueryItem(
        QString("hl"), QString(to)
    );
    q.addQueryItem(
        QString("ie"), QString("UTF-8")
    );
    //tl=en&tsel=0
    q.addQueryItem(
        QString("kc"), QString("7")
    );
    q.addQueryItem(
        QString("oe"), QString("UTF-8")
    );
    q.addQueryItem(
        QString("ie"), QString("UTF-8")
    );
    q.addQueryItem(
        QString("otf"), QString("1")
    );
    q.addQueryItem(
        QString("q"), QString(str)
    );
    q.addQueryItem(
        QString("sl"), QString(from)
    );
    q.addQueryItem(
        QString("ssel"), QString("0")
    );
    q.addQueryItem(
        QString("tk"), QString("669614.669614")
    );
    q.addQueryItem(
        QString("tl"), QString(to)
    );
    q.addQueryItem(
        QString("tsel"), QString("0")
    );
    return q;
}

void Google::httpFinished(QNetworkReply *reply) {
    if (reply->error() == QNetworkReply::NoError) {
        jsonDecode(reply->readAll());
    } else {
        setError(reply->errorString());
    }
    reply->deleteLater();
}

void Google::jsonDecode(QByteArray data) {
    QJsonDocument json = QJsonDocument::fromJson(data);
    if (!json.isArray()) {
        setError(
            QString("error unmarshalling response: %1").arg(QString(data))
        );
        return;
    }
    QJsonValue v = json.array().first().toArray().first().toArray().first();
    setOut(v.toString());
}
