import QtQuick 2.2
import Nemo.Configuration 1.0
import Sailfish.Silica 1.0;

Page {
    property string path: "/apps/translator"

    ConfigurationValue {
        id: settingsLastFrom
        key: path+"/lastFrom"
        defaultValue: ""
    }

    ConfigurationValue {
        id: settingsLastTo
        key: path+"/lastTo"
        defaultValue: ""
    }

    property alias lastTo : settingsLastTo
    property alias lastFrom : settingsLastFrom
}
