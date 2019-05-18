import QtQuick 2.0
import Sailfish.Silica 1.0
import "pages"
import "settings"
import Translator 1.0

ApplicationWindow {
    property string lastFrom: ""
    property string lastTo: ""
    property string lastText: ""
    property string lastOut: ""

    Settings {
        id: settings
    }

    initialPage: Component {
        MainPage {
        }
    }
    cover: Qt.resolvedUrl("cover/CoverPage.qml")
    allowedOrientations: defaultAllowedOrientations
}
