#ifndef ABSTRACT_TRANSLATOR_H
#define ABSTRACT_TRANSLATOR_H

#include <QObject>

class AbstractTranslator : public QObject {
    Q_OBJECT
    Q_PROPERTY(QString from           READ from           WRITE setFrom   NOTIFY fromChanged )
    Q_PROPERTY(QString to             READ to             WRITE setTo     NOTIFY toChanged   )
    Q_PROPERTY(bool    isErr          READ isErr                          NOTIFY errorChanged)
    Q_PROPERTY(QString text           READ text           WRITE setText   NOTIFY textChanged )
    Q_PROPERTY(QString out            READ out                            NOTIFY translated  )
    Q_PROPERTY(QString name           READ name                           NOTIFY nameChanged )
protected:
    QString m_from;
    QString m_to;
    QString m_text;
    QString m_out;
    bool    m_isErr;
public:
    explicit AbstractTranslator(QObject *parent = nullptr);
    virtual ~AbstractTranslator();

    virtual QString name()         const = 0;
    virtual QList<QString> langs() const = 0;

    QString from()  const;
    QString to()    const;
    QString text()  const;
    QString out()   const;
    bool    isErr() const;

public slots:
    // translate performs the translation of the string `str`
    // from the language `from` to the language `to`.
    virtual void translate(void) = 0;
    virtual void setFrom(const QString &from);
    virtual void setTo(const QString &to);
    virtual void setText(const QString &text);
    virtual void setError(const QString &error);
    virtual void setOut(const QString &text);

signals:
    void nameChanged(const QString &name);
    void fromChanged(const QString &from);
    void toChanged(const QString &to);
    void translated(const QString &text);
    void textChanged(const QString &text);
    void errorChanged(const bool &isErr);
    void finished(void);
};

#endif // ABSTRACT_TRANSLATOR_H
