#include "deepl.h"

Deepl::Deepl(QObject *parent) : AbstractTranslator(parent) {
    m_qnam = new QNetworkAccessManager();
    connect(m_qnam, &QNetworkAccessManager::finished, this,  &Deepl::httpFinished);
    m_langs.append({
       new Language { "en", "English"},
       new Language { "es", "Spanish"},
       new Language { "de", "German"}
   });
}

Deepl::~Deepl() {
    delete m_qnam;
}

QString Deepl::name() const {
    return "Deepl";
}

QList<QString> Deepl::langs() const {
    return m_langs.toList();
}

void Deepl::translate() {

}

void Deepl::httpFinished(QNetworkReply *reply) {

}

