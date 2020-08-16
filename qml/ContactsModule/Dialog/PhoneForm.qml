import QtQuick 2.0
import QtQuick.Controls 2.12

Rectangle {

    property alias phone: _phone

    id: root

    TextField {
        id: _phone
        width: root.width * 0.5
        height: root.height * 0.2
        font.pointSize: Math.min(root.width, root.height) * 0.07
        horizontalAlignment: TextInput.AlignHCenter
        verticalAlignment: TextInput.AlignVCenter

        anchors.centerIn: root

        placeholderText: "Enter Phone..."
    }
}
