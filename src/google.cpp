#include "google.h"

Google::Google(QObject *parent) : AbstractTranslator(parent) {
    m_url = QUrl("https://translate.google.com/translate_a/single");
    m_qnam = new QNetworkAccessManager();
    connect(m_qnam, &QNetworkAccessManager::finished, this,  &Google::httpFinished);
    m_langs.append({
                       new Language { "af",  "Afrikaans" },
                       //new Language { "am",  "አማርኛ" },
                       new Language { "ar",  "العربية" },
                       new Language { "as",  "অসমীয়া" },
                       new Language { "az",  "azərbaycan" },
                       new Language { "be",  "беларуская" },
                       new Language { "bg",  "български" },
                       new Language { "bn",  "বাংলা" },
                       new Language { "bs",  "bosanski" },
                       new Language { "ca",  "català" },
                       new Language { "ccp",  "Chakma" },
                       new Language { "ceb",  "Cebuano" },
                       //new Language { "chr",  "ᏣᎳᎩ" },
                       new Language { "ckb",  "کوردیی ناوەندی" },
                       new Language { "co",  "Corsican" },
                       new Language { "cs",  "Čeština" },
                       new Language { "cy",  "Cymraeg" },
                       new Language { "da",  "Dansk" },
                       new Language { "de",  "Deutsch" },
                       new Language { "el",  "Ελληνικά" },
                       new Language { "en",  "English" },
                       new Language { "eo",  "esperanto" },
                       new Language { "es",  "Español" },
                       new Language { "et",  "eesti" },
                       new Language { "eu",  "Euskara" },
                       new Language { "fa",  "فارسی" },
                       new Language { "ff",  "Pulaar" },
                       new Language { "fi",  "Suomi" },
                       new Language { "fil", "Filipino" },
                       new Language { "fr",  "Français" },
                       new Language { "fy",  "Frysk" },
                       new Language { "ga",  "Gaeilge" },
                       new Language { "gd",  "Gàidhlig" },
                       new Language { "gl",  "Galego" },
                       new Language { "gu",  "ગુજરાતી" },
                       new Language { "haw",  "ʻŌlelo Hawaiʻi" },
                       new Language { "he",  "עברית" },
                       new Language { "hi",  "हिन्दी" },
                       new Language { "hmn",  "Hmong" },
                       new Language { "hr",  "Hrvatski" },
                       new Language { "ht",  "Haitian Creole" },
                       new Language { "hu",  "magyar" },
                       new Language { "hy",  "հայերեն" },
                       new Language { "id",  "Indonesia" },
                       new Language { "is",  "íslenska" },
                       new Language { "it",  "Italiano" },
                       new Language { "iu",  "Inuktitut" },
                       new Language { "ja",  "日本語" },
                       new Language { "jv",  "Jawa" },
                       new Language { "jw",  "Jawa" },
                       new Language { "ka",  "ქართული" },
                       new Language { "kk",  "қазақ тілі" },
                       new Language { "ko",  "한국어" },
                       new Language { "ku",  "kurdî" },
                       new Language { "ky",  "кыргызча" },
                       new Language { "la",  "Latin" },
                       new Language { "lb",  "Lëtzebuergesch" },
                       new Language { "lis",  "Lisu" },
                       new Language { "lo",  "ລາວ" },
                       new Language { "lt",  "lietuvių" },
                       new Language { "lv",  "latviešu" },
                       new Language { "mez",  "Menominee" },
                       new Language { "mg",  "Malagasy" },
                       new Language { "mi",  "Māori" },
                       new Language { "mk",  "македонски" },
                       new Language { "ml",  "മലയാളം" },
                       new Language { "mn",  "монгол" },
                       new Language { "mni-Mtei",  "Manipuri (Meitei Mayek)" },
                       new Language { "mr",  "मराठी" },
                       new Language { "ms",  "Melayu" },
                       new Language { "mt",  "Malti" },
                       new Language { "mul", "Multiple languages" },
                       new Language { "nb",  "norsk" },
                       new Language { "ne",  "नेपाली" },
                       new Language { "nl",  "Nederlands" },
                       new Language { "nn",  "nynorsk" },
                       new Language { "no",  "norsk" },
                       new Language { "nv",  "Navajo" },
                       new Language { "ny",  "Nyanja" },
                       new Language { "oj",  "Ojibwa" },
                       new Language { "one",  "Oneida" },
                       new Language { "or",  "ଓଡ଼ିଆ" },
                       new Language { "osa",  "Osage" },
                       new Language { "pa",  "ਪੰਜਾਬੀ" },
                       new Language { "pl",  "polski" },
                       new Language { "ps",  "پښتو" },
                       new Language { "pt-BR",  "Português (Brasil)" },
                       new Language { "pt-PT",  "Português (Portugal)" },
                       new Language { "ro",  "română" },
                       new Language { "rom",  "Romany" },
                       new Language { "ru",  "Русский" },
                       new Language { "sa",  "Sanskrit" },
                       new Language { "sd",  "سنڌي" },
                       new Language { "see",  "Seneca" },
                       new Language { "si",  "සිංහල" },
                       new Language { "sk",  "Slovenčina" },
                       new Language { "sl",  "slovenščina" },
                       new Language { "sm",  "Samoan" },
                       new Language { "sn",  "chiShona" },
                       new Language { "so",  "Soomaali" },
                       new Language { "sq",  "shqip" },
                       new Language { "sr",  "српски" },
                       new Language { "su",  "Sundanese" },
                       new Language { "sv",  "Svenska" },
                       new Language { "sw",  "Kiswahili" },
                       new Language { "ta",  "தமிழ்" },
                       new Language { "tg",  "тоҷикӣ" },
                       new Language { "th",  "ไทย" },
                       new Language { "ti",  "ትግርኛ" },
                       new Language { "tl",  "Filipino" },
                       new Language { "tr",  "Türkçe" },
                       new Language { "tt",  "татар" },
                       new Language { "ug",  "ئۇيغۇرچە" },
                       new Language { "uk",  "Українська" },
                       new Language { "ur",  "اردو" },
                       new Language { "uz",  "o‘zbek" },
                       new Language { "uzs",  "Southern Uzbek" },
                       new Language { "vi",  "Tiếng Việt" },
                       new Language { "xh",  "isiXhosa" },
                       new Language { "yi",  "ייִדיש" },
                       new Language { "zh-CN", "简体中文" },
                       new Language { "zh-HK", "中文（香港）" },
                       new Language { "zh-Hans", "简体中文（中国）" },
                       new Language { "zh-Hant", "繁體中文（台灣）" },
                       new Language { "zh-TW", "繁體中文" },
                       new Language { "zh-yue", "粵語" },
                       new Language { "zu",  "isiZulu" }
                   });
}

Google::~Google() {
    delete m_qnam;
}

QString Google::name() const {
    return "Google";
}

QList<QString> Google::langs() const {
    return m_langs.toList();
}

void Google::translate() {
    QUrl url(m_url);
    url.setQuery(buildQuery(m_text));

    QNetworkRequest req(url);
    // TODO: Use a user agent list
    req.setRawHeader("Referrer Policy", "no-referrer-when-downgrade");
    req.setHeader(QNetworkRequest::UserAgentHeader, "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.75 Safari/537.36");

    QNetworkReply *reply = m_qnam->get(req);
    QTimer timer;
    timer.setSingleShot(true);

    connect(&timer, &QTimer::timeout,         reply, &QNetworkReply::abort);
    connect(reply,  &QNetworkReply::finished, this,  &AbstractTranslator::finished);

    timer.start(20000); // 20 seconds
}

QString Google::getAbbrLng(QString lang) {
    for (Language *s : m_langs.list()) {
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
