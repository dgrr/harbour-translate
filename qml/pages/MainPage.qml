import QtQuick 2.2
import Sailfish.Silica 1.0
import Translator 1.0
import QtQmlTricks 3.0
import "../pages"

Page {
    id: page
    allowedOrientations: Orientation.All

    Translator {
        id: translator
        platform: Translator.GOOGLE
        onSubmitChanged: {
            lastText = input.text
        }
    }

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

        TextField {
            id: box1
            readOnly: true
            width: parent.width
            anchors {
                top: pageHeader.bottom
            }
            text: settings.lastFrom
            color: Theme.primaryColor
            horizontalAlignment: TextInput.AlignHCenter
            placeholderText: "From..."
            font.pixelSize: Theme.fontSizeLarge
            onTextChanged: {
                translator.from = text
                lastFrom = text
            }
            onClicked: {
                pageStack.push(dialogSelectorFrom)
            }
            property alias value : box1.text
        }

        IconButton {
            id: iconButton
            enabled: !translator.submit
            opacity: (enabled ? 1 : 0)
            anchors {
                top: box1.bottom
                horizontalCenter: parent.horizontalCenter
            }
            icon.source: "image://theme/icon-m-data-download?" + Theme.primaryColor
            onClicked: {
                rotationAnimation.start()
                hideAnimation.start()
            }
            RotationAnimator {
                id: rotationAnimation
                target: iconButton
                from: 0
                to: 180
                duration: 300
                running: false
            }
        }
        BusyIndicator {
            id: busyIndicator
            enabled: translator.submit
            opacity: enabled ? 1 : 0
            anchors {
                centerIn: iconButton
            }
            size: BusyIndicatorSize.Medium
        }
        IconButton {
            id: stopButton
            enabled: translator.submit
            opacity: enabled ? 1 : 0
            anchors {
                centerIn: busyIndicator
            }
            icon.source: "image://theme/icon-m-clear?" + Theme.primaryColor
            onClicked: input.text = ""
        }
        IconButton {
            id: btnNextPage
            enabled: !translator.submit
            opacity: enabled ? 1 : 0
            anchors {
                top: box1.bottom
                right: parent.right
            }
            icon.source: "image://theme/icon-m-right?" + Theme.primaryColor
            onClicked: {
                var dialog = pageStack.push(dialogTranslated)
            }
        }

        TextField {
            id: box2
            readOnly: true
            width: parent.width
            anchors {
                top: (iconButton.enabled ? iconButton.bottom : busyIndicator.bottom)
                topMargin: Theme.paddingLarge
            }
            text: settings.lastTo
            color: Theme.primaryColor
            horizontalAlignment: TextInput.AlignHCenter
            placeholderText: "To..."
            font.pixelSize: Theme.fontSizeLarge
            onTextChanged: {
                translator.to = text
                lastTo = text
            }
            onClicked: {
                pageStack.push(dialogSelectorTo)
            }
            property alias value : box2.text
        }

        ParallelAnimation {
            id: hideAnimation
            running: false
            onStopped: {
                var v = box1.value
                box1.value = box2.value
                box2.value = v
                pumpAnimation.start()
            }
            OpacityAnimator {
                target: box1
                from: 1
                to: 0
            }
            OpacityAnimator {
                target: box2
                from: 1
                to: 0
            }
        }
        ParallelAnimation {
            id: pumpAnimation
            running: false
            OpacityAnimator {
                target: box1
                from: 0
                to: 1
            }
            OpacityAnimator {
                target: box2
                from: 0
                to: 1
            }
        }

        TextArea {
            id: input
            anchors {
                top: box2.bottom
                topMargin: Theme.paddingLarge
                left: parent.left
                leftMargin: clearButton.width
                right: clearButton.left
            }
            placeholderText: box1.value.length > 0 ? qsTr(box1.value + " text...") : ""
            color: Theme.primaryColor
            font.pixelSize: Theme.fontSizeLarge
            autoScrollEnabled: true
            horizontalAlignment: TextEdit.AlignHCenter
            onTextChanged: {
                translator.text = text
            }
        }
        IconButton {
            id: clearButton
            enabled: input.text.length > 0
            opacity: enabled ? 1 : 0
            anchors.right: parent.right
            anchors.top: box2.bottom
            icon.source: "image://theme/icon-m-clear?" + Theme.primaryColor
            onClicked: input.text = ""
        }

        TextArea {
            id: outBox
            anchors.bottom: parent.bottom
            width: parent.width
            enabled: false
            opacity: (text.length > 0) ? 1 : 0
            color: (translator.isErr) ? "red" : Theme.primaryColor
            font.pixelSize: Theme.fontSizeLarge
            horizontalAlignment: TextEdit.AlignHCenter
            text: translator.out
            autoScrollEnabled: true
            onTextChanged: {
                if (!translator.isErr) {
                    var texts = settings.translations
                    for (var i in texts) {
                        if (texts[i].res === text
                                && texts[i].text === input.text) {
                            return // should not be repeated
                        }
                    }
                    lastOut = text
                    texts.push({
                                   "from": box1.value,
                                   "to": box2.value,
                                   "text": lastText,
                                   "res": text
                               })
                    settings.translations = texts
                }
            }
        }
    }

    Component {
        id: dialogTranslated
        PageTranslated {
        }
    }
    Component {
        id: dialogSelectorFrom
        PageSelectorSrc {}
    }
    Component {
        id: dialogSelectorTo
        PageSelectorDst {}
    }
}
