#ifndef T_GLOBAL_H
#define T_GLOBAL_H

#include <QObject>
#include <QHash>
#include <QTimer>
#include <QAbstractListModel>

#include "google.h"
#include "yandex.h"
#include "deepl.h"

#include "abstract_translator.h"

#include <QQmlListProperty>

class T_Global : public QObject {
    Q_OBJECT
    Q_PROPERTY(QString from           READ from         WRITE setFrom     NOTIFY fromChanged            )
    Q_PROPERTY(QString to             READ to           WRITE setTo       NOTIFY toChanged              )
    Q_PROPERTY(bool    isErr          READ isErr                          NOTIFY errorChanged           )
    Q_PROPERTY(QString text           READ text         WRITE setText     NOTIFY textChanged            )
    Q_PROPERTY(QString out            READ out                            NOTIFY translated             )
    Q_PROPERTY(QString name           READ name                           NOTIFY nameChanged            )
    Q_PROPERTY(int platform           READ platform     WRITE setPlatform NOTIFY platformChanged        )
    Q_PROPERTY(bool submit            READ submit                         NOTIFY submitChanged          )
    Q_PROPERTY(QList<QString> langs   READ langs                          NOTIFY supportedLangsChanged  )
public:
    explicit T_Global(QObject *parent = nullptr);
    ~T_Global();

    enum TranslatorType {
        NONE         = -1,
        GOOGLE       = 0,
        YANDEX       = 1,
        DEEPL        = 2,
        MAX_PLATFORM = 3
    };
    Q_ENUM(TranslatorType)

    QString name()   const;
    int platform()   const;
    QString from()   const;
    QString to()     const;
    QString out()    const;
    QString text()   const;
    bool    isErr()  const;
    bool    submit() const;
    QList<QString> langs() const;

private:
    int m_current = NONE;
    int m_submit = false;
    QList<QString> m_langs;
    AbstractTranslator *m_tr    = nullptr;
    AbstractTranslator *m_pl[MAX_PLATFORM];
    QTimer             *m_timer = nullptr;

    void retranslate(void);

public slots:
    void finished(void);
    void translate(void);
    void setFrom(const QString &text);
    void setTo(const QString &to);
    void setText(const QString &text);
    void setError(const QString &error);
    void setOut(const QString &text);
    void setPlatform(const int &platform);

signals:
    void nameChanged(const QString &name);
    void fromChanged(const QString &from);
    void toChanged(const QString &to);
    void translated(const QString &text);
    void textChanged(const QString &text);
    void errorChanged(const bool &isErr);
    void platformChanged(const int &platform);
    void supportedLangsChanged(QList<QString> list);
    void submitChanged(const bool &submit);
};

#endif // T_GLOBAL_H
