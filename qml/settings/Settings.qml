import QtQuick 2.2
import Nemo.Configuration 1.0
import Sailfish.Silica 1.0

Page {
    property string path: "/apps/translator"

    ConfigurationValue {
        id: settingsLastFrom
        key: path + "/lastFrom"
        defaultValue: ""
    }

    ConfigurationValue {
        id: settingsLastTo
        key: path + "/lastTo"
        defaultValue: ""
    }

    ConfigurationValue {
        id: settingsTranslations
        key: path + "/translations"
        defaultValue: []
    }

    ConfigurationValue {
        id: settingsFavLangs
        key: path + "/favs"
        defaultValue: []
    }

    property alias lastTo: settingsLastTo.value
    property alias lastFrom: settingsLastFrom.value
    property alias translations: settingsTranslations.value
    property alias favLangs: settingsFavLangs.value
}
