import QtQuick 2.2
import Sailfish.Silica 1.0
import QtQmlTricks 3.0

Page {
    id: page

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: favsColumn.height + langsColumn.height

        PageHeader {
            id: header
            title: "Destination language list"
        }

        ColumnView {
            id: favsColumn
            anchors {
                top: header.bottom
                topMargin: Theme.paddingLarge
            }
            x: Theme.horizontalPageMargin
            width: parent.width - Theme.horizontalPageMargin * 2
            itemHeight: Theme.itemSizeSmall
            model: settings.favLangs.length

            delegate: BackgroundItem {
                id: delegate
                width: parent.width
                property string value: settings.favLangs[index].lang

                ContextMenu {
                    id: removeMenu

                    MenuItem {
                        text: "Remove"
                        width: parent.width
                        onClicked: Remorse.itemAction(delegate,
                                                      qsTr("Removing"),
                                                      function () {
                                                          var texts = settings.favLangs
                                                          var nTexts = []
                                                          for (var i in texts) {
                                                              if (texts[i].lang
                                                                      !== delegate.value) {
                                                                  nTexts.push(texts[i])
                                                              }
                                                          }
                                                          settings.favLangs = nTexts
                                                      })
                    }
                }

                MouseArea {
                    anchors.fill: parent

                    Label {
                        text: qsTr(settings.favLangs[index].lang)
                        anchors.fill: parent
                        color: (settings.favLangs[index].lang === translator.to) ? Theme.highlightColor : Theme.primaryColor
                    }

                    onPressAndHold: {
                        removeMenu.open(delegate)
                    }

                    onReleased: {
                        if (removeMenu.active) {
                            removeMenu.close()
                        }
                    }

                    onClicked: {
                        settings.lastTo = value
                        settings.favLangs[index].usages++
                        pageStack.pop()
                    }
                }
            }

            RowContainer {
                id: separator
                anchors.top: favsColumn.bottom
                width: parent.width

                Separator {
                    color: Theme.primaryColor
                    ExtraAnchors.horizontalFill: parent
                }
            }

            ColumnView {
                id: langsColumn
                anchors {
                    top: separator.bottom
                    topMargin: Theme.paddingLarge
                    left: parent.left
                }
                itemHeight: Theme.itemSizeSmall
                model: translator.langs.length

                delegate: BackgroundItem {
                    width: parent.width
                    property string value: translator.langs[index]
                    MouseArea {
                        anchors.fill: parent
                        Label {
                            text: qsTr(translator.langs[index])
                            anchors.fill: parent
                            color: (translator.langs[index] === translator.to) ? Theme.highlightColor : Theme.primaryColor
                        }
                        onClicked: {
                            var langs = settings.favLangs
                            var to = translator.to // if previusly don't exists

                            settings.lastTo = value
                            if (to == "") { // nothing to add to fav
                                pageStack.pop()
                                return;
                            }

                            for (var i = 0; i < langs.length; i++) {
                                if (langs[i].lang === value) {
                                    langs[i].usages++
                                    pageStack.pop()
                                    return;
                                }
                            }
                            langs.push({usages: 1, lang: value})
                            settings.favLangs = langs

                            pageStack.pop()
                        }
                    }
                }
            }
        }
    }
}
