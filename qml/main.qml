import QtQuick 2.9
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import StyleSettings 1.0
import ContactsModule.ListView 1.0
import ContactsModule.Dialog 1.0
import Contacts 1.0

Window {
    id: root

    width: 640
    height: 480
    title: "Phonebook"
    visible: true

    property int currentContact: -1
    property int orderBy: 0

    ContactDialog {
        id: _contactDialog
        width: root.width * 0.7
        height: root.height * 0.9
        onFinished: {
            if (currentContact === -1) {
                _contactView.model.model.append(name, email, phones)
                _sortFilterModel.update()
            } else {
                _contactView.model.model.set(currentContact, name, email, phones)
                _sortFilterModel.update()
            }
        }
    }

    TextField {
        id: _searchText

        width: root.width
        height: Math.min(root.height * 0.1, 50)

        font.pointSize: height * 0.3

        placeholderText: "Enter Name or Phone..."
        onTextChanged: _sortFilterModel.update()
    }

    SortFilterModel {
        id: _sortFilterModel

        model: ContactsModel {
            id: _contactsModel
        }

        filterAcceptsItem: function(item) {
            if (!item.name.includes(_searchText.text) && !item.email.includes(_searchText.text)) {
                for (let i = 0; i < item.phones.length; i++)
                  if (item.phones[i].includes(_searchText.text)) return true
            } else return true
        }

        lessThan: function(left, right) {
            if (orderBy == 0) {
                var leftVal = left.name;
                var rightVal = right.name;
            } else if (orderBy == 1) {
                leftVal = left.email;
                rightVal = right.email;
            }
            return leftVal < rightVal
        }

        delegate: ContactsDelegate {
            id: _contactsDelegate
            width: root.width
            height: Math.min(root.width, 500) / 7
        }
    }

    ContactsView {
        id: _contactView

        width: root.width
        height: root.height - _searchText.height

        anchors {
            top: _searchText.bottom
        }

        model: _sortFilterModel
    }

    RoundButton {
        id: _sortByBtn
        text: "Name"

        width: root.width / 7
        height: root.height / 10

        highlighted: true

        anchors {
            right: parent.right
            bottom: _roundBtn.top
            bottomMargin: Style.tinyOffset
        }

        onClicked: {
            if (orderBy == 0) {
                orderBy = 1
                _sortByBtn.text = "Email"
                _sortFilterModel.update()
            } else if (orderBy == 1) {
                orderBy = 0
                _sortByBtn.text = "Name"
                _sortFilterModel.update()
            }
        }
    }

    RoundButton {
        id: _roundBtn
        text: "+"

        width: Math.min(root.width, root.height) * 0.15;
        height: width

        highlighted: true

        anchors {
            margins: Style.mediumOffset
            right: parent.right
            bottom: parent.bottom
        }

        onClicked: {
            currentContact = -1
            _contactDialog.createContact()
        }
    }

    Rectangle {
        id: _background
        z: -100
        anchors.fill: parent
        color: Style.backgroundColor
        opacity: Style.emphasisOpacity
    }
}
