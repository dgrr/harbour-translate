import QtQuick 2.2
import Sailfish.Silica 1.0
import QtQmlTricks 3.0

Page {
    id: page
    allowedOrientations: Orientation.All

    SilicaListView {
        anchors.fill: parent
        header: PageHeader {
            title: "Translated text"
        }

        model: ListModel {
            id: listModel
            function groupByLang() {
                var content = []
                // content = [{
                //      title: string
                //      contents: [{
                //          from: string
                //          to: string
                //      }]
                // }]
                var texts = settings.translations
                for (var i = 0; i < texts.length; i++) {
                    var shouldAdd = true
                    var text = texts[i]
                    var title = text.from + " > " + text.to
                    for (var j = 0; j < content.length; j++) {
                        if (content[j].title === title) {
                            shouldAdd = false
                            content[j].contents.push({
                                                         "from": text.text,
                                                         "to": text.res
                                                     })
                            break
                        }
                    }
                    if (shouldAdd) {
                        content.push({
                                         "title": title,
                                         "contents": [{
                                                 "from": text.text,
                                                 "to": text.res
                                             }]
                                     })
                    }
                }
                return content
            }

            function complete() {
                listModel.clear()
                listModel.append(groupByLang())
            }

            Component.onCompleted: listModel.complete()
        }

        delegate: ListItem {
            id: delegateItem
            x: Theme.horizontalPageMargin
            width: parent.width - Theme.horizontalPageMargin*2
            height: columnContainer.height
            property string value : title

            Column {
                id: columnContainer
                width: parent.width
                anchors.topMargin: Theme.paddingLarge * 10

                Label {
                    anchors.left: parent.left
                    text: title
                    color: Theme.secondaryColor
                }

                ColumnView {
                    width: parent.width
                    itemHeight: Theme.itemSizeSmall
                    model: contents
                    delegate: ListItem {
                        id: listItem
                        width: parent.width
                        property string value : to // TODO: Change it to an id

                        Column {
                            width: parent.width

                            Label {
                                text: "> "+from
                                anchors {
                                    leftMargin: Theme.paddingLarge
                                    left: parent.left
                                }
                                horizontalAlignment: Text.AlignHCenter
                                color: Theme.primaryColor
                                wrapMode: Label.WordWrap
                            }

                            Label {
                                text: "> "+to
                                anchors {
                                    leftMargin: Theme.paddingLarge
                                    left: parent.left
                                }
                                horizontalAlignment: Text.AlignHCenter
                                color: Theme.primaryColor
                                wrapMode: Label.WordWrap
                            }

                            Separator {
                                width: parent.width
                                color: Theme.primaryColor
                            }
                        }
                        openMenuOnPressAndHold: false
                        onClicked: listItem.openMenu()
                        menu: ContextMenu {
                            id: ctxMenu
                            MenuItem {
                                text: "Remove"
                                onClicked: listItem.remorseAction(qsTr("Removing"), function() {
                                                                  var texts = settings.translations
                                                                  var nTexts = []
                                                                  for (var i = 0; i < texts.length; i++) {
                                                                      if (texts[i].res !== listItem.value) {
                                                                          nTexts.push(texts[i])
                                                                      }
                                                                  }
                                                                  settings.translations = nTexts
                                                                  listModel.complete()
                                                              })
                            }
                        }
                    }
                }
            }
            /*menu: Remorse.itemAction(delegateItem, qsTr("Removing"),
                                     function () {
                                         var texts = settings.translations
                                         var nTexts = []
                                         for (var i in texts) {
                                             if (texts[i].res !== delegateItem.labelText) {
                                                 nTexts.push(texts[i])
                                             }
                                         }
                                         settings.translations = nTexts
                                     })*/
        }
        VerticalScrollDecorator {
        }
    }
}
