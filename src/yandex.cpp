#include "yandex.h"

Yandex::Yandex(QObject *parent) : AbstractTranslator(parent) {
    m_qnam = new QNetworkAccessManager();
    connect(m_qnam, &QNetworkAccessManager::finished, this,  &Yandex::httpFinished);
    m_langs.append({
       new Language { "en", "English"},
       new Language { "es", "Spanish"},
       new Language { "de", "German"}
   });
}

Yandex::~Yandex() {
    delete m_qnam;
}

QString Yandex::name() const {
    return "Yandex";
}

QList<QString> Yandex::langs() const {
    return m_langs.toList();
}

void Yandex::translate() {

}

void Yandex::httpFinished(QNetworkReply *reply) {
}
