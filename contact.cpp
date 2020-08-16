#include "contact.h"

Contact::Contact(QString name, QString email)
    : m_name(std::move(name)), m_email(std::move(email))
{}

Contact::Contact(QString name, QString email, std::vector<QString> phones)
    : m_name(std::move(name)), m_email(std::move(email)), m_phones(std::move(phones))
{}

const QString& Contact::getName() const {
    return m_name;
}

void Contact::setName(const QString& value) {
    m_name = value;
}

const QString& Contact::getEmail() const {
    return m_email;
}

void Contact::setEmail(const QString& value) {
    m_email = value;
}

const std::vector<QString>& Contact::getPhones() const {
    return m_phones;
}

void Contact::setPhones(const std::vector<QString>& phones) {
    m_phones = phones;
}
