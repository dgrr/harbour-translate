import QtQuick 2.0
import Sailfish.Silica 1.0

CoverBackground {
    Label {
        id: title
        anchors.topMargin: Theme.paddingLarge
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: Theme.fontSizeLarge
        text: qsTr("Translator")
    }

    Label {
        id: from
        anchors.topMargin: Theme.paddingLarge*2
        anchors.top: title.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        color: Theme.secondaryColor
        font.pixelSize: Theme.fontSizeMedium
        text: qsTr(translator.from)
    }

    Label {
        id: text
        anchors.top: from.bottom
        horizontalAlignment: Theme.horizontalPageMargin
        anchors.horizontalCenter: parent.horizontalCenter
        color: Theme.primaryColor
        font.pixelSize: Theme.fontSizeLarge
        text: qsTr(translator.text)
    }

    Label {
        id: to
        anchors.topMargin: Theme.paddingLarge
        anchors.top: text.bottom
        horizontalAlignment: Theme.horizontalPageMargin
        anchors.horizontalCenter: parent.horizontalCenter
        color: Theme.secondaryColor
        font.pixelSize: Theme.fontSizeMedium
        text: qsTr(translator.to)
    }

    Label {
        id: out
        anchors.top: to.bottom
        horizontalAlignment: Theme.horizontalPageMargin
        anchors.horizontalCenter: parent.horizontalCenter
        color: Theme.primaryColor
        font.pixelSize: Theme.fontSizeLarge
        text: qsTr(translator.out)
    }
}
