import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import ContactsModule.Utils 1.0
import ContactsModule.ListView 1.0
import StyleSettings 1.0

Rectangle {

    property alias name: _name
    property alias email: _email
    property var phones: []
    property bool isReadOnly: true

    id: root

    TextField {
        id: _name
        width: root.width * 0.4
        height: root.height * 0.17
        font.pointSize: Math.min(root.width, root.height) * 0.07
        horizontalAlignment: TextInput.AlignHCenter
        verticalAlignment: TextInput.AlignVCenter

        anchors {
            top: root.top
            left: root.left
            margins: Style.mediumOffset
        }

        placeholderText: "Enter Name..."
        readOnly: isReadOnly
    }

    TextField {
        id: _email
        width: root.width * 0.4
        height: root.height * 0.17
        font.pointSize: Math.min(root.width, root.height) * 0.07
        horizontalAlignment: TextInput.AlignHCenter
        verticalAlignment: TextInput.AlignVCenter

        anchors {
            left: _name.right
            verticalCenter: _name.verticalCenter
            margins: Style.mediumOffset
        }

        placeholderText: "Enter Email..."
        readOnly: isReadOnly
    }

    Button {
        id: _btnAddPhone

        width: _name.width * 0.8
        height: root.height * 0.15
        text: "Add"
        font.pointSize: height * 0.2

        anchors {
            top: _name.bottom
            horizontalCenter: root.Center
            margins: Style.mediumOffset
        }

        onClicked: {
            _phoneDialog.addPhone()
        }
    }

    ListView {
        id: _phonesView

        width: root.width
        height: root.height - _name.height * 2 - Style.mediumOffset * 2

        spacing: 2
        clip: true

        boundsBehavior: Flickable.StopAtBounds

        anchors {
            top: _btnAddPhone.bottom
            topMargin: Style.mediumOffset
        }

        model: phones.length

        delegate: PhonesDelegate {
            id: _phonesDelegate
            width: _phonesView.width
            height: _phonesView.width / 7
            color: "grey"
        }

        ScrollBar.vertical: ScrollBar { }
    }

    PhoneDialog {
        id: _phoneDialog
        width: root.width * 0.7
        height: root.height * 0.9
        onFinished: {
            phones.push(phone)
            updateModel()
        }
    }

    function updateModel() {
        phones = phones
    }
}
