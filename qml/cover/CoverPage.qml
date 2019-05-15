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
        width: parent.width
        anchors.top: from.bottom
        horizontalAlignment: TextInput.AlignHCenter
        anchors.horizontalCenter: parent.horizontalCenter
        color: Theme.primaryColor
        font.pixelSize: Theme.fontSizeMedium
        text: qsTr(translator.text)
        truncationMode: TruncationMode.Elide
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
        width: parent.width
        anchors.top: to.bottom
        horizontalAlignment: TextInput.AlignHCenter
        anchors.horizontalCenter: parent.horizontalCenter
        color: Theme.primaryColor
        font.pixelSize: Theme.fontSizeMedium
        text: qsTr(translator.out)
        truncationMode: TruncationMode.Elide
    }

    Image {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        asynchronous: true
        source: "qrc:///icons/128x128/translate.png"
    }
}
