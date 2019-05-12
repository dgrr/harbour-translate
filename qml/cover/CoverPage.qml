import QtQuick 2.0
import Sailfish.Silica 1.0
import Translator 1.0

CoverBackground {
    Translator {
        id: translator
    }

    Label {
        horizontalAlignment: Theme.horizontalPageMargin
        anchors.centerIn: parent
        font.pixelSize: Theme.fontSizeLarge
        text: qsTr("Translator")
    }

    Label {
        id: last
        horizontalAlignment: Theme.horizontalPageMargin
        text: qsTr(translator.text)
    }

    Label {
        id: current
        horizontalAlignment: Theme.horizontalPageMargin
        text: qsTr(translator.text)
    }
}
