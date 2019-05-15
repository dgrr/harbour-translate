#include "t_global.h"

T_Global::T_Global(QObject *parent) : QObject(parent) {
    m_timer = new QTimer(this);
    m_timer->setSingleShot(true);
    connect(m_timer, SIGNAL(timeout()), this, SLOT(translate()));
    m_pl[GOOGLE] = new Google(this);
    m_pl[YANDEX] = new Yandex(this);
    m_pl[DEEPL]  = new Deepl(this);
}

T_Global::~T_Global(void) {
    delete m_pl[GOOGLE];
    delete m_timer;
}

QString T_Global::name() const {
    if (m_tr == nullptr)
        return "";
    return m_tr->name();
}

int T_Global::platform() const {
    return m_current;
}

QString T_Global::from() const {
    if (m_tr == nullptr)
        return "";
    return m_tr->from();
}

QString T_Global::to() const {
    if (m_tr == nullptr)
        return "";
    return m_tr->to();
}

QString T_Global::out() const {
    if (m_tr == nullptr)
        return "";
    return m_tr->out();
}

QString T_Global::text() const {
    if (m_tr == nullptr)
        return "";
    return m_tr->text();
}

QList<QString> T_Global::langs() const {
    if (m_tr == nullptr) {
        return QList<QString>();
    }
    return m_tr->langs();
}

bool T_Global::isErr() const {
    if (m_tr == nullptr)
        return false;
    return m_tr->isErr();
}

bool T_Global::submit() const {
    return m_submit;
}

void T_Global::translate(void) {
    if (m_tr == nullptr)
        return;
    if (m_submit)
        return; // do not submit more than one request at a time

    if (m_tr->from() != m_tr->to() && m_tr->text().length() > 0) {
        m_tr->translate();
        m_submit = true;
        emit submitChanged(m_submit);
    }
}

void T_Global::retranslate(void) {
    if (m_tr == nullptr)
        return;

    m_timer->start(500);
}

void T_Global::finished(void) {
    m_submit = false;
    emit submitChanged(m_submit);
}

void T_Global::setFrom(const QString &from) {
    if (m_tr == nullptr)
        return;

    if (from == m_tr->to()) {
        setError("Languages cannot be the same");
    } else {
        setError("");
    }

    m_tr->setFrom(from);
}

void T_Global::setTo(const QString &to) {
    if (m_tr == nullptr)
        return;

    if (to == m_tr->from()) {
        setError("Languages cannot be the same");
    } else {
        setError("");
    }

    m_tr->setTo(to);
}

void T_Global::setText(const QString &text) {
    if (m_tr == nullptr)
        return;

    m_timer->start(2000);
    m_tr->setText(text);
}

void T_Global::setError(const QString &error) {
    if (m_tr == nullptr)
        return;

    m_tr->setError(error);
}

void T_Global::setOut(const QString &text) {
    if (m_tr == nullptr)
        return;

    m_tr->setOut(text);
}

void T_Global::setPlatform(const int &platform) {
    if (platform >= MAX_PLATFORM || platform <= NONE ) {
        setError(QString("Platform does not exist"));
        return;
    }

    AbstractTranslator *tr = m_tr;
    m_tr = m_pl[platform];
    m_current = platform;

    if (tr != nullptr) {
        disconnect(tr, &AbstractTranslator::fromChanged,  this, &T_Global::fromChanged);
        disconnect(tr, &AbstractTranslator::toChanged,    this, &T_Global::toChanged);
        disconnect(tr, &AbstractTranslator::textChanged,  this, &T_Global::textChanged);
        disconnect(tr, &AbstractTranslator::translated,   this, &T_Global::translated);
        disconnect(tr, &AbstractTranslator::errorChanged, this, &T_Global::errorChanged);

        disconnect(tr, &AbstractTranslator::toChanged,   this, &T_Global::retranslate);
        disconnect(tr, &AbstractTranslator::fromChanged, this, &T_Global::retranslate);

        disconnect(tr, &AbstractTranslator::finished, this, &T_Global::finished);
    }

    connect(m_tr, &AbstractTranslator::fromChanged,  this, &T_Global::fromChanged);
    connect(m_tr, &AbstractTranslator::toChanged,    this, &T_Global::toChanged);
    connect(m_tr, &AbstractTranslator::textChanged,  this, &T_Global::textChanged);
    connect(m_tr, &AbstractTranslator::translated,   this, &T_Global::translated);
    connect(m_tr, &AbstractTranslator::errorChanged, this, &T_Global::errorChanged);

    connect(m_tr, &AbstractTranslator::toChanged,   this, &T_Global::retranslate);
    connect(m_tr, &AbstractTranslator::fromChanged, this, &T_Global::retranslate);

    connect(m_tr, &AbstractTranslator::finished, this, &T_Global::finished);

    emit platformChanged(platform);
    emit nameChanged(m_tr->name());
    emit supportedLangsChanged(m_tr->langs());
}
