#include <QtQuick>
#include <QtQml>
#include <sailfishapp.h>

#include "t_global.h"

int main(int argc, char *argv[]) {
    QGuiApplication *app = SailfishApp::application(argc, argv);
    if (app == nullptr) {
        return 1;
    }

    QQuickView *view = SailfishApp::createView();
    if (view == nullptr) {
        return 1;
    }

    qmlRegisterType<T_Global>("Translator", 1, 0, "Translator");

    app->setApplicationName("translate");
    app->setQuitOnLastWindowClosed(true);
    view->setSource(SailfishApp::pathToMainQml());
    view->show();

    return app->exec();
}
