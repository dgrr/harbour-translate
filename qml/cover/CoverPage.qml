import QtQuick 2.6
import Sailfish.Silica 1.0
import QtQmlTricks 3.0
import "../components"

CoverBackground {
    id: cover
    Image {
        height: width;
        opacity: 0.15;
        anchors {
            topMargin: (cover.height * +0.05);
            leftMargin: (cover.width * -0.05);
            rightMargin: (cover.width * +0.05);
        }
        source: "qrc:///icons/128x128/translate.png";
        ExtraAnchors.topDock: parent;
    }

    ColumnContainer {
        spacing: Theme.paddingLarge;
        anchors {
            margins: Theme.paddingLarge;
            verticalCenter: parent.verticalCenter;
        }
        ExtraAnchors.horizontalFill: parent;

        LabelFixed {
            text: "Translator";
            color: Theme.primaryColor;
            font.pixelSize: Theme.fontSizeLarge;
            anchors.horizontalCenter: parent.horizontalCenter;
        }

        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            color: Theme.secondaryColor
            font.pixelSize: Theme.fontSizeMedium
            text: qsTr(lastFrom)
        }

        Label {
            horizontalAlignment: TextInput.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            color: Theme.primaryColor
            font.pixelSize: Theme.fontSizeMedium
            text: qsTr(lastText)
            truncationMode: TruncationMode.Elide
        }

        Label {
            horizontalAlignment: Theme.horizontalPageMargin
            anchors.horizontalCenter: parent.horizontalCenter
            color: Theme.secondaryColor
            font.pixelSize: Theme.fontSizeMedium
            text: qsTr(lastTo)
        }

        Label {
            horizontalAlignment: TextInput.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            color: Theme.primaryColor
            font.pixelSize: Theme.fontSizeMedium
            text: qsTr(lastOut)
            truncationMode: TruncationMode.Elide
        }
    }
}
