#include "abstract_translator.h"

AbstractTranslator::AbstractTranslator(QObject *parent) : QObject(parent) {}
AbstractTranslator::~AbstractTranslator() {}

QString AbstractTranslator::from() const {
    return m_from;
}

QString AbstractTranslator::to() const {
    return m_to;
}

QString AbstractTranslator::text() const {
    return m_text;
}

bool AbstractTranslator::isErr() const {
    return m_isErr;
}

QString AbstractTranslator::out() const {
    return m_out;
}

void AbstractTranslator::setFrom(const QString &from) {
    m_from = from;
    emit fromChanged(from);
}

void AbstractTranslator::setTo(const QString &to) {
    m_to = to;
    emit toChanged(to);
}

void AbstractTranslator::setText(const QString &text) {
    m_text = text;
    emit textChanged(text);
}

void AbstractTranslator::setError(const QString &error) {
    m_isErr = true;
    m_out = error;
    emit translated(error);
    emit errorChanged(m_isErr);
}

void AbstractTranslator::setOut(const QString &text) {
    m_isErr = false;
    m_out = text;
    emit translated(text);
    emit errorChanged(m_isErr);
}
