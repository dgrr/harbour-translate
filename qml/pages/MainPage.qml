import QtQuick 2.2
import Sailfish.Silica 1.0
import Translator 1.0

Page {
    id: page
    allowedOrientations: Orientation.All

    Translator {
        id: translator
        platform: Translator.GOOGLE
    }

    SilicaFlickable {
        anchors.fill: parent

        PullDownMenu {
            MenuItem {
                text: qsTr("Google")
                onClicked: translator.platform = Translator.GOOGLE
            }
            MenuItem {
                text: qsTr("Yandex")
                onClicked: translator.platform = Translator.YANDEX
            }
            MenuItem {
                text: qsTr("Deepl")
                onClicked: translator.platform = Translator.DEEPL
            }
        }

        PageHeader {
            id: pageHeader
            title: qsTr(translator.name)
        }

        ComboBox {
            id: box1
            anchors.top: pageHeader.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            currentIndex: 0
            menu: ContextMenu {
                MenuItem {
                    text: qsTr("Spanish")
                }
                MenuItem {
                    text: qsTr("English")
                }
            }
            onValueChanged: translator.from = value;
        }
        IconButton {
            id: iconButton
            anchors.top: box1.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            icon.source: "image://theme/icon-m-data-download?" + (pressed ? Theme.highlightColor : Theme.primaryColor)
            width: parent.width
            onClicked: {
                var i = box1.currentIndex
                var v = box1.value
                box1._updateCurrent(box2.currentIndex, box2.value)
                box2._updateCurrent(i, v)
            }
        }
        ComboBox {
            id: box2
            anchors.top: iconButton.bottom
            width: parent.width
            currentIndex: 1
            menu: ContextMenu {
                MenuItem {
                    text: qsTr("Spanish")
                }
                MenuItem {
                    text: qsTr("English")
                }
            }
            onValueChanged: translator.to = value;
        }

        TextField {
            id: input
            anchors.top: box2.bottom
            width: parent.width
            placeholderText: qsTr(box1.value + " text...")
            color: Theme.primaryColor
            font.pixelSize: Theme.fontSizeLarge
            autoScrollEnabled: true
            horizontalAlignment: TextEdit.AlignHCenter
            onTextChanged: translator.text = text
        }

        Rectangle {
            id: r1
            color: "green"
            anchors.top: input.bottom
            anchors.bottom: outBox.top
            x: Theme.horizontalPageMargin
            width: parent.width - Theme.horizontalPageMargin*2
        }

        TextArea {
            id: outBox
            anchors.bottom: parent.bottom
            width: parent.width
            enabled: false
            opacity: (text.length > 0) ? 1 : 0;
            color: (translator.isErr) ? "red" : Theme.primaryColor
            font.pixelSize: Theme.fontSizeLarge
            horizontalAlignment: TextEdit.AlignHCenter
            text: translator.out
            autoScrollEnabled: true
        }
    }
}
