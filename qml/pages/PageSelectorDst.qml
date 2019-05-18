import QtQuick 2.2
import Sailfish.Silica 1.0
import QtQmlTricks 3.0

Page {
    id: page
    property string show: ""

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: mainColumn.height

        Column {
            id: mainColumn
            width: parent.width

            PageHeader {
                title: "Destination language list"
            }

            ColumnView {
                id: firstColumn
                x: Theme.horizontalPageMargin
                width: parent.width - Theme.horizontalPageMargin * 2
                anchors.topMargin: Theme.paddingLarge
                itemHeight: Theme.itemSizeSmall
                model: settings.favLangs.length

                delegate: ListItem {
                    id: delegate
                    width: parent.width
                    property string value: settings.favLangs[index].lang

                    ContextMenu {
                        id: removeMenu
                        MenuItem {
                            text: "Remove"
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
                        width: parent.width
                        anchors.fill: parent
                        Label {
                            text: qsTr(settings.favLangs[index].lang)
                            anchors.left: parent.left
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
            }

            RowContainer {
                x: Theme.horizontalPageMargin
                width: parent.width - Theme.horizontalPageMargin * 2
                Separator {
                    color: Theme.primaryColor
                    ExtraAnchors.horizontalFill: parent
                }
            }

            ColumnView {
                id: secondColumn
                x: Theme.horizontalPageMargin
                width: parent.width - Theme.horizontalPageMargin * 2
                itemHeight: Theme.itemSizeSmall
                model: translator.langs.length

                delegate: BackgroundItem {
                    width: parent.width
                    property string value: translator.langs[index]
                    MouseArea {
                        anchors.fill: parent
                        Label {
                            text: qsTr(translator.langs[index])
                            anchors.left: parent.left
                        }
                        onClicked: {
                            var langs = settings.favLangs
                            var to = translator.to // if previusly don't exists

                            settings.lastTo = value
                            if (to == "") {
                                // nothing to add to fav
                                pageStack.pop()
                                return
                            }

                            for (var i in langs) {
                                if (langs[i].lang === value) {
                                    langs[i].usages++
                                    pageStack.pop()
                                    return
                                }
                            }
                            langs.push({
                                           "usages": 1,
                                           "lang": value
                                       })
                            settings.favLangs = langs

                            pageStack.pop()
                        }
                    }
                }
            }
        }
    }
}
