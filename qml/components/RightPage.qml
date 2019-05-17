import QtQuick 2.2
import Sailfish.Silica 1.0
import QtQmlTricks 3.0;

Page {
    id: page
    SilicaListView {
        id: listView
        model: settings.translations.length
        anchors.fill: parent
        header: PageHeader {
            title: "Translated text"
        }

        delegate: ListItem {
            id: delegate
            x: Theme.horizontalPageMargin
            width: parent.width - Theme.horizontalPageMargin*2
            property string labelText : settings.translations[index].res

            ColumnContainer {
                width: parent.width
                RowContainer {
                    id: titleRow
                    width: parent.width
                    Container.horizontalStretch: 1
                    ExtraAnchors.horizontalFill: parent

                    Label {
                        id: fromLabel
                        anchors.left: parent.left
                        text: settings.translations[index].from
                        color: Theme.secondaryColor
                    }

                    Label {
                        id: slabel
                        anchors.left: fromLabel.right
                        text: qsTr("  >  ")
                        color: Theme.secondaryColor
                    }

                    Label {
                        anchors.left: slabel.right
                        text: settings.translations[index].to
                        color: Theme.secondaryColor
                    }
                }

                RowContainer {
                    anchors.top: titleRow.bottom
                    Container.horizontalStretch: 1
                    ExtraAnchors.horizontalFill: parent

                    Label {
                        id: textLabel
                        text: settings.translations[index].text
                        color: Theme.primaryColor
                    }

                    Label {
                        id: separatorLabel
                        text: qsTr("  >  ")
                        anchors.horizontalCenter: parent.horizontalCenter
                        color: Theme.secondaryColor
                    }

                    Label {
                        anchors.left: separatorLabel.right
                        text: settings.translations[index].res
                        color: Theme.primaryColor
                    }
                }
            }

            menu: ContextMenu {
                MenuItem {
                    text: "Remove"
                    onClicked: {
                        var texts = settings.translations
                        var nTexts = [];
                        for (var i in texts) {
                            if (texts[i].res !== delegate.labelText) {
                                nTexts.push(texts[i])
                            }
                        }
                        settings.translations = nTexts
                    }
                }
            }
        }
        VerticalScrollDecorator {}
    }
}
