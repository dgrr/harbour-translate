import QtQuick 2.2
import Sailfish.Silica 1.0
import QtQmlTricks 3.0

Page {
    id: page

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: mainColumn.height

        Column {
            id: mainColumn
            width: parent.width

            PageHeader {
                title: "Source language list"
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
                    MouseArea {
                        anchors.fill: parent
                        Label {
                            text: qsTr(settings.favLangs[index].lang)
                            anchors.left: parent.left
                        }
                        onClicked: {
                            settings.lastFrom = value
                            settings.favLangs[index].usages++
                            pageStack.pop()
                        }
                    }
                    menu: ContextMenu {
                        MenuItem {
                            text: "Remove"
                            onClicked: Remorse.itemAction(delegate,
                                                          qsTr("Deleting"),
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
                            var from = translator.from // if previusly don't exists

                            settings.lastFrom = value
                            if (from == "") { // nothing to add to fav
                                pageStack.pop()
                                return;
                            }

                            for (var i in langs) {
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
