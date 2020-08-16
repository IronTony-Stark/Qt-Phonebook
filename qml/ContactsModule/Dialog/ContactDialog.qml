import QtQuick 2.12
import QtQuick.Controls 2.12

Dialog {
    id: root

    signal finished(string name, string email, var phones)

    function createContact() {
        form.name.clear();
        form.email.clear();
        form.phones = []
        form.isReadOnly = false;

        root.title = "Add Contact";
        root.open();
    }

    function viewContact(contact) {
        form.name.text = contact.name;
        form.email.text = contact.email;
        form.phones = contact.phones;

        form.isReadOnly = true;

        root.title = "View Contact";
        root.open();
    }

    function editContact(contact) {
        form.name.text = contact.name;
        form.email.text = contact.email;
        form.phones = contact.phones;

        form.isReadOnly = false;

        root.title = "Edit Contact";
        root.open();
    }

    x: parent.width / 2 - width / 2
    y: parent.height / 2 - height / 2

    focus: true
    modal: true
    standardButtons: form.isReadOnly ? Dialog.Ok : Dialog.Ok | Dialog.Cancel

    contentItem: ContactForm {
        id: form
    }

    onAccepted: {
        if (!form.readOnly) finished(form.name.text, form.email.text, form.phones)
    }
}
