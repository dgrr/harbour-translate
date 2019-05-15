import QtQuick 2.2
import Sailfish.Silica 1.0
import Translator 1.0

Page {
    id: page
    allowedOrientations: Orientation.All

    SilicaFlickable {
        anchors.fill: parent

        PullDownMenu {
            MenuItem {
                text: qsTr("Google")
                onClicked: translator.platform = Translator.GOOGLE
            }
            MenuItem {
                enabled: false
                text: qsTr("Yandex")
                onClicked: translator.platform = Translator.YANDEX
            }
            MenuItem {
                enabled: false
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
            currentIndex: {
                for (var i = 0; i < translator.langs.length; i++) {
                    var lang = translator.langs[i]
                    if (lang === settings.lastFrom.value) {
                        return i;
                    }
                }
                return 0;
            }
            menu: ContextMenu {
                Repeater {
                    model: translator.langs.length
                    MenuItem {
                        text: qsTr(translator.langs[index])
                    }
                }
            }
            onValueChanged: {
                settings.lastFrom.value = value
                translator.from = value;
                //settings.lastFrom.sync()
            }
            Behavior on opacity {
                FadeAnimation{duration: 200}
            }
        }

        IconButton {
            id: iconButton
            enabled: !translator.submit
            opacity: (enabled ? 1 : 0)
            anchors.top: box1.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            icon.source: "image://theme/icon-m-data-download?" + Theme.primaryColor
            width: parent.width
            onClicked: {
                rotationAnimation.start()
                hideAnimation.start()
            }
            RotationAnimator {
                id: rotationAnimation
                target: iconButton;
                from: 0;
                to: 180;
                duration: 300
                running: false
            }
        }
        BusyIndicator {
            id: busyIndicator
            enabled: translator.submit
            opacity: (enabled ? 1 : 0)
            anchors.top: box1.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            size: BusyIndicatorSize.Medium
        }

        ComboBox {
            id: box2
            anchors.top: (iconButton.enabled ? iconButton.bottom : busyIndicator.bottom )
            width: parent.width
            currentIndex: {
                for (var i = 0; i < translator.langs.length; i++) {
                    var lang = translator.langs[i]
                    if (lang === settings.lastTo.value) {
                        return i;
                    }
                }
                return 1;
            }
            menu: ContextMenu {
                Repeater {
                    model: translator.langs.length
                    MenuItem {
                        text: qsTr(translator.langs[index])
                    }
                }
            }
            onValueChanged: {
                settings.lastTo.value = value
                translator.to = value;
                //settings.lastTo.sync()
            }
            Behavior on opacity {
                FadeAnimation{duration: 200}
            }
        }

        ParallelAnimation {
            id: hideAnimation
            running: false
            onStopped: {
                var i = box1.currentIndex
                var v = box1.value
                box1._updateCurrent(box2.currentIndex, box2.value)
                box2._updateCurrent(i, v)
                pumpAnimation.start()
            }
            OpacityAnimator { target: box1; from: 1; to: 0 }
            OpacityAnimator { target: box2; from: 1; to: 0 }
        }
        ParallelAnimation {
            id: pumpAnimation
            running: false
            OpacityAnimator { target: box1; from: 0; to: 1 }
            OpacityAnimator { target: box2; from: 0; to: 1 }
        }

        TextArea {
            id: input
            anchors.top: box2.bottom
            width: parent.width
            placeholderText: qsTr(box1.value + " text...")
            color: Theme.primaryColor
            font.pixelSize: Theme.fontSizeLarge
            autoScrollEnabled: true
            horizontalAlignment: TextEdit.AlignHCenter
            onTextChanged: {
                translator.text = text
            }
        }

        Item {
            id: r1
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
