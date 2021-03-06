#ifndef LANGUAGE_H
#define LANGUAGE_H

#include <QObject>

class Language {
private:
    QString m_abbr;
    QString m_name;
public:
    Language(const QString &abbr, const QString &name);
    Language(const Language &lang);

    QString abbr() const;
    QString name() const;
};

class Languages {
private:
    QList<Language *> m_langs;
    QList<QString> m_names;
public:
    void append(const QList<Language *> &t);
    QList<QString> toList()  const;
    QList<Language *> list() const;
};

#endif // LANGUAGE_H
