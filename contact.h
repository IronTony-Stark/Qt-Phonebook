#ifndef CONTACT_H
#define CONTACT_H

#include <QString>
#include <vector>

class Contact {

  public:
    Contact() = default;
    Contact(QString name, QString email);
    Contact(QString name, QString email, std::vector<QString> phones);

    const QString& getName() const;
    void setName(const QString& value);

    const QString& getEmail() const;
    void setEmail(const QString& value);

    const std::vector<QString>& getPhones() const;
    void setPhones(const std::vector<QString>& phones);

  private:
    QString m_name;
    QString m_email;
    std::vector<QString> m_phones;
};

#endif // CONTACT_H
