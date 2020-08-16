import QtQuick 2.0
import QtQuick.Controls 2.12

Dialog {
    id: root

    signal finished(string phone)

    function addPhone() {
        form.phone.clear();

        root.title = "Add Phone";
        root.open();
    }

    x: parent.width / 2 - width / 2
    y: parent.height / 2 - height / 2

    focus: true
    modal: true
    standardButtons: Dialog.Ok | Dialog.Cancel

    contentItem: PhoneForm {
        id: form
    }

    onAccepted: {
        finished(form.phone.text)
    }
}
