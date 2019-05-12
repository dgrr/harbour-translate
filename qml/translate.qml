import QtQuick 2.0
import Sailfish.Silica 1.0
import "pages"
import Translator 1.0

ApplicationWindow {
    Translator {
        id: translator
        platform: Translator.GOOGLE
    }

    initialPage: Component { MainPage { } }
    cover: Qt.resolvedUrl("cover/CoverPage.qml")
    allowedOrientations: defaultAllowedOrientations
}
