import QtQuick 2.2
import Sailfish.Silica 1.0
import Translator 1.0
import QtQmlTricks 3.0
import "../pages"

Page {
    id: page
    allowedOrientations: Orientation.Portrait | Orientation.Landscape

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
            enabled: !input.activeFocus
            opacity: enabled ? 1 : 0
            width: parent.width / 3
            readOnly: true
            anchors {
                top: pageHeader.bottom
                right: {
                    if (page.orientation == Orientation.Landscape) {
                        return iconButton.left
                    }
                }

                horizontalCenter: {
                    if (page.orientation == Orientation.Portrait) {
                        return parent.horizontalCenter
                    }
                }
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
            property alias value: box1.text
        }

        IconButton {
            id: iconButton
            enabled: !translator.submit && !input.activeFocus
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

            states: State {
                when: page.orientation == Orientation.Landscape
                AnchorChanges {
                    target: iconButton
                    anchors.top: pageHeader.bottom
                }
                PropertyChanges {
                    target: iconButton
                    rotation: 90
                }
            }

            transitions: Transition {
                ParallelAnimation {
                    AnchorAnimation {
                        duration: 200
                    }
                    RotationAnimation {
                        duration: 200
                        direction: RotationAnimation.Clockwise
                    }
                }
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
            enabled: !translator.submit && !input.activeFocus
            opacity: enabled ? 1 : 0
            anchors {
                top: page.orientation == Orientation.Portrait ? box1.bottom : pageHeader.bottom
                right: parent.right
            }
            icon.source: "image://theme/icon-m-right?" + Theme.primaryColor
            onClicked: {
                var dialog = pageStack.push(dialogTranslated)
            }
        }

        TextField {
            id: box2
            enabled: !input.activeFocus
            opacity: enabled ? 1 : 0
            width: parent.width / 3
            readOnly: true
            anchors {
                top: {
                    if (page.orientation == Orientation.Landscape) {
                        return pageHeader.bottom
                    }
                    return (iconButton.enabled ? iconButton.bottom : busyIndicator.bottom)
                }
                topMargin: page.orientation == Orientation.Landscape ? 0 : Theme.paddingLarge
                left: {
                    if (page.orientation == Orientation.Landscape) {
                        return (iconButton.enabled ? iconButton.right : busyIndicator.right)
                    }
                }
                horizontalCenter: {
                    if (page.orientation == Orientation.Portrait) {
                        return parent.horizontalCenter
                    }
                }
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
            property alias value: box2.text
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
                right: page.orientation == Orientation.Portrait ? clearButton.left : submitLandscapeButton.left
            }
            placeholderText: box1.value.length > 0 ? qsTr(box1.value + " text...") : ""
            color: Theme.primaryColor
            font.pixelSize: Theme.fontSizeLarge
            autoScrollEnabled: true
            horizontalAlignment: TextEdit.AlignHCenter
            onTextChanged: {
                translator.text = text
            }
            focus: activeFocus && !translator.submit

            states: State {
                when: input.activeFocus
                AnchorChanges {
                    target: input
                    anchors.top: pageHeader.bottom
                }
            }

            transitions: Transition {
                AnchorAnimation {
                    duration: 100
                }
            }
        }
        IconButton {
            id: clearButton
            enabled: input.text.length > 0 && !input.activeFocus
            opacity: enabled ? 1 : 0
            anchors.right: parent.right
            anchors.top: box2.bottom
            icon.source: "image://theme/icon-m-clear?" + Theme.primaryColor
            onClicked: input.text = ""
        }
        Button { // this button does not submit the request, just hides the keyboard
            // only works when orientation == Portrait
            id: submitPortraitButton
            enabled: input.activeFocus && input.softwareInputPanelEnabled && page.orientation == Orientation.Portrait
            opacity: enabled ? 1 : 0
            anchors {
                top: input.bottom
                horizontalCenter: input.horizontalCenter
            }

            onClicked: input.focus = false

            text: qsTr("Translate")
        }
        IconButton {
            id: submitLandscapeButton
            enabled: input.activeFocus && input.softwareInputPanelEnabled && page.orientation != Orientation.Portrait
            opacity: enabled ? 1 : 0
            icon.source: "image://theme/icon-m-right?"+Theme.primaryColor
            anchors {
                top: pageHeader.bottom
                right: parent.right
            }

            onClicked: input.focus = false
        }

        TextArea {
            id: outBox
            anchors.bottom: parent.bottom
            width: parent.width
            enabled: false
            opacity: (text.length > 0 && !input.activeFocus ) ? 1 : 0
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
                            return
                            // should not be repeated
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
        PageSelectorSrc {
        }
    }
    Component {
        id: dialogSelectorTo
        PageSelectorDst {
        }
    }
}
