#ifndef CONTACTSMODEL_H
#define CONTACTSMODEL_H

#include <QAbstractListModel>
#include "contact.h"

class ContactsModel : public QAbstractListModel {

    Q_OBJECT

  public:
    ContactsModel(QObject* parent = 0);

    int rowCount(const QModelIndex& parent) const override;
    QHash<int, QByteArray> roleNames() const override;
    QVariant data(const QModelIndex& index, int role) const override;

    Q_INVOKABLE QVariantMap get(int row) const;
    Q_INVOKABLE void set(int row, const QString& name, const QString& email, std::vector<QString> phones);
    Q_INVOKABLE void append(const QString& name, const QString& email, std::vector<QString> phones);
    Q_INVOKABLE bool removeRows(int row, int count, const QModelIndex& parent = QModelIndex()) override;

    enum ContactRoles {
        NameRole = Qt::UserRole + 1,
        EmailRole,
        PhonesRole,
    };

  private:
    std::vector<Contact> m_contacts;
    void updateContacts();
};

#endif // CONTACTSMODEL_H
