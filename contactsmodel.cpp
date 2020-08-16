#include <QQmlEngine>
#include "QDebug"
#include "contactsmodel.h"

ContactsModel::ContactsModel(QObject* parent) : QAbstractListModel(parent) {
    updateContacts();
    emit dataChanged(createIndex(0, 0), createIndex(static_cast<int>(m_contacts.size()), 0));
}

int ContactsModel::rowCount(const QModelIndex& parent) const {
    Q_UNUSED(parent)
    return static_cast<int>(m_contacts.size());
}

QHash<int, QByteArray> ContactsModel::roleNames() const {
    QHash<int, QByteArray> roles;

    roles[ContactRoles::NameRole] = "name";
    roles[ContactRoles::EmailRole] = "email";
    roles[ContactRoles::PhonesRole] = "phones";

    return roles;
}

QVariant ContactsModel::data(const QModelIndex& index, int role) const {
    if (!index.isValid() || index.row() > rowCount(index)) return QVariant();

    const Contact& contact = m_contacts.at(index.row());

    switch (role) {
    case NameRole:
        return QVariant::fromValue(contact.getName());
    case EmailRole:
        return QVariant::fromValue(contact.getEmail());
    case PhonesRole:
        return QVariant::fromValue(contact.getPhones());
    default:
        return QVariant();
    }
}

bool ContactsModel::removeRows(int row, int count, const QModelIndex& parent) {
    Q_UNUSED(parent)

    if (row < 0 || row >= static_cast<int>(m_contacts.size()))
        return false;

    beginRemoveRows(QModelIndex(), row, row + count - 1);

    for (int i = 0; i < count; i++)
        m_contacts.erase(m_contacts.begin() + row + i);

    endRemoveRows();

    return true;
}

void ContactsModel::updateContacts() {
    for (int i = 0; i < 10; i++) {
        std::vector<QString> phones;
        for (int j = 0; j < i; j++)
            phones.emplace_back(QString("+1234567890 %1").arg(j));
        m_contacts.emplace_back(Contact(QString("Name %1").arg(i), QString("Email %1").arg(i), phones));
    }
}

void ContactsModel::set(int row, const QString& name, const QString& email, std::vector<QString> phones) {
    if (row < 0 || row >= static_cast<int>(m_contacts.size()))
        return;

    m_contacts[row] = { name, email, std::move(phones) };
    emit dataChanged(index(row, 0), index(row, 0), { NameRole, EmailRole, PhonesRole });
}

QVariantMap ContactsModel::get(int row) const {
    const Contact& contact = m_contacts.at(row);

    QVariantMap map;
    map["name"] = contact.getName();
    map["email"] = contact.getEmail();
    map["phones"] = QVariant::fromValue(contact.getPhones());

    return map;
}

void ContactsModel::append(const QString& name, const QString& email, std::vector<QString> phones) {
    int row = 0;

    beginInsertRows(QModelIndex(), row, row);

    m_contacts.insert(m_contacts.begin() + row, Contact(name, email, std::move(phones)));

    endInsertRows();
}
