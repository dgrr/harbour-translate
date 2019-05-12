#ifdef QT_QML_DEBUG
#include <QtQuick>
#endif

#include "t_global.h"
#include <sailfishapp.h>
#include <QtQml>

int main(int argc, char *argv[])
{
    QGuiApplication *app = SailfishApp::application(argc, argv);
    if (app == nullptr) {
        qDebug() << "SailfishApp::application is nullptr";
        return 1;
    }

    QQuickView *view = SailfishApp::createView();
    if (view == nullptr) {
        qDebug() << "SailfishApp::createView is nullptr";
        return 1;
    }

    qmlRegisterType<T_Global>("Translator", 1, 0, "Translator");

    app->setApplicationName("translate");
    app->setQuitOnLastWindowClosed(true);
    view->setSource(SailfishApp::pathToMainQml());
    view->show();

    return app->exec();
}
