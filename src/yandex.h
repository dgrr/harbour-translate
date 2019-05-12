#ifndef YANDEX_H
#define YANDEX_H

#include <QObject>

class Yandex : public QObject
{
    Q_OBJECT
public:
    explicit Yandex(QObject *parent = nullptr);

signals:

public slots:
};

#endif // YANDEX_H
