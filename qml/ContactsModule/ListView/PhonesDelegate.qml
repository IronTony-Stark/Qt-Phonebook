import QtQuick 2.0
import QtQuick.Controls 2.12
import ContactsModule.Utils 1.0

Rectangle {
    id: root

    BaseText {
        text: phones[index]
        anchors.centerIn: parent
    }

    MouseArea {
        width: _phonesDelegate.width
        height: _phonesDelegate.height
        acceptedButtons: Qt.LeftButton | Qt.RightButton

        onClicked: {
            if (mouse.button === Qt.RightButton)
                _delegateContextMenu.popup()
        }

        onPressAndHold: {
            _delegateContextMenu.popup()
        }
    }

    Menu {
        id: _delegateContextMenu

        MenuItem {
            text: "Delete"

            onClicked: {
                phones.splice(index, 1)
                updateModel()
            }
        }
    }
}
