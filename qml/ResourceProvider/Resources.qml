pragma Singleton
import QtQuick 2.0
import StyleSettings 1.0

Item {
    property alias contacts: _contacts
    QtObject {
        id: _contacts
        readonly property string defaultContactIcon: Style.isDarkTheme ? "qrc:/qml/resources/user-white.svg" :
                                                                         "qrc:/qml/resources/user-black.svg"
    }
}
