import QtQuick 2.0
import QtQuick.Controls 2.14
import ContactsModule.Utils 1.0
import StyleSettings 1.0
import ResourceProvider 1.0

Rectangle {
    id: root

    color: Style.backgroundColor
    opacity: _delegateArea.pressed ? Style.secondaryOpacity : Style.emphasisOpacity

    ImageBubble {
        id: _contactBubble

        image.source: Resources.contacts.defaultContactIcon

        width: root.height * 0.8
        height: root.height * 0.8

        anchors {
            leftMargin: Style.mediumOffset
            left: root.left
            rightMargin: Style.largeOffset
            verticalCenter: root.verticalCenter
        }
    }

    BaseText {
        id: _nameText

        text: name
        font.pointSize: root.height * 0.3

        anchors {
            leftMargin: Style.mediumOffset
            left: _contactBubble.right
            verticalCenter: root.verticalCenter
        }
    }

    BaseText {
        id: _emailText

        text: email
        font.pointSize: root.height * 0.3

        anchors {
            leftMargin: Style.mediumOffset
            left: _nameText.right
            verticalCenter: root.verticalCenter
        }
    }

    MouseArea {
        id: _delegateArea
        anchors.fill: root
        acceptedButtons: Qt.LeftButton | Qt.RightButton

        onClicked: {
            if (mouse.button === Qt.LeftButton) {
                currentContact = index
                 _contactDialog.viewContact(_contactsModel.get(currentContact))
            }

            if (mouse.button === Qt.RightButton)
                _delegateContextMenu.popup()
        }

        onPressAndHold: {
            _delegateContextMenu.popup()
        }

        Menu {
            id: _delegateContextMenu

            MenuItem {
                text: "Edit"

                onClicked: {
                    currentContact = index
                     _contactDialog.editContact(_contactsModel.get(currentContact))
                }
            }

            MenuItem {
                text: "Delete"

                onClicked: {
                    _contactsModel.removeRows(index, 1)
                }
            }
        }
    }
}
