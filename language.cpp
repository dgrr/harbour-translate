#include "language.h"

Language::Language(const QString &abbr, const QString &name) :
    m_abbr(abbr),
    m_name(name)
{}

Language::Language(const Language &lang) {
    m_abbr = lang.m_abbr;
    m_name = lang.m_name;
}

QString Language::abbr() const {
    return m_abbr;
}

QString Language::name() const {
    return m_name;
}
