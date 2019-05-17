import QtQuick 2.2
import Sailfish.Silica 1.0
import Translator 1.0
import QtQmlTricks 3.0
import "../components"

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

        ComboBox {
            id: box1
            anchors.top: pageHeader.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            currentIndex: {
                var i;
                var lang;
                for (i = 0; i < settings.favLangs.length; i++) {
                    lang = settings.favLangs[i].lang
                    if (lang === settings.lastFrom) {
                        return i;
                    }
                }
                for (i = 0; i < translator.langs.length; i++) {
                    lang = translator.langs[i]
                    if (lang === settings.lastFrom) {
                        return i + settings.favLangs.length;
                    }
                }
                return 0 + settings.favLangs.length;
            }
            menu: ContextMenu {
                Repeater {
                    model: settings.favLangs.length
                    MenuItem {
                        text: qsTr(settings.favLangs[index].lang)
                        color: Theme.highlightColor
                    }
                }

                Repeater {
                    model: translator.langs.length
                    MenuItem {
                        text: qsTr(translator.langs[index])
                        color: Theme.primaryColor
                    }
                }
            }
            onValueChanged: {
                var langs = settings.favLangs
                var from = translator.from

                lastFrom = value

                settings.lastFrom = value
                translator.from = value;
                if (from == "") {
                    return;
                }

                for (var i in langs) {
                    if (langs[i].lang === value) {
                        langs[i].usages++
                        return;
                    }
                }
                langs.push({usages: 1, lang: value})
                settings.favLangs = langs
            }
            Behavior on opacity {
                FadeAnimation {
                    duration: 200
                }
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
            opacity: enabled ? 1 : 0
            anchors.top: box1.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            size: BusyIndicatorSize.Medium
        }
        IconButton {
            id: stopButton
            enabled: translator.submit
            opacity: enabled ? 1 : 0
            anchors.centerIn: busyIndicator
            icon.source: "image://theme/icon-m-clear?"+Theme.primaryColor
            onClicked: input.text = ""
        }
        IconButton {
            id: btnNextPage
            enabled: !translator.submit
            opacity: enabled ? 1 : 0
            anchors.top: box1.bottom
            anchors.right: parent.right
            icon.source: "image://theme/icon-m-right?"+Theme.primaryColor
            onClicked: {
                var dialog = pageStack.push(dialogTranslated)
            }
        }

        ComboBox {
            id: box2
            anchors.top: (iconButton.enabled ? iconButton.bottom : busyIndicator.bottom )
            width: parent.width
            currentIndex: {
                var i;
                var lang;
                for (i = 0; i < settings.favLangs.length; i++) {
                    lang = settings.favLangs[i].lang
                    if (lang === settings.lastTo) {
                        return i;
                    }
                }

                for (i = 0; i < translator.langs.length; i++) {
                    lang = translator.langs[i]
                    if (lang === settings.lastTo) {
                        return i + settings.favLangs.length;
                    }
                }
                return 3;
            }
            menu: ContextMenu {
                Repeater {
                    model: settings.favLangs.length
                    MenuItem {
                        text: qsTr(settings.favLangs[index].lang)
                        color: Theme.highlightColor
                    }
                    anchors.bottomMargin: Theme.paddingLarge
                }

                Repeater {
                    model: translator.langs.length
                    MenuItem {
                        text: qsTr(translator.langs[index])
                        color: Theme.primaryColor
                    }
                }
            }
            onValueChanged: {
                var langs = settings.favLangs
                var to = translator.to

                lastTo = value

                settings.lastTo = value
                translator.to = value
                if (to == "") {
                    return;
                }

                for (var i in langs) {
                    if (langs[i].lang === value) {
                        langs[i].usages++
                        return;
                    }
                }
                langs.push({usages: 1, lang: value})
                settings.favLangs = langs
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
            anchors {
                top: box2.bottom
                left: parent.left
                leftMargin: clearButton.width
                right: clearButton.left
            }
            placeholderText: qsTr(box1.value + " text...")
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
            icon.source: "image://theme/icon-m-clear?"+Theme.primaryColor
            onClicked: input.text = ""
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
            onTextChanged: {
                if (!translator.isErr) {
                    var texts = settings.translations
                    for (var i in texts) {
                        if (texts[i].res === text && texts[i].text === input.text) {
                            return; // should not be repeated
                        }
                    }
                    lastOut = text
                    texts.push({
                                   from: box1.value,
                                   to: box2.value,
                                   text: lastText,
                                   res: text
                               })
                    settings.translations = texts
                }
            }
        }
    }

    Component {
        id: dialogTranslated
        RightPage {}
    }
}
