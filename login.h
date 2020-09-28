#pragma once

#define SQL_DISABLE_MYSQL
#define SQL_DISABLE_PGSQL
#include <sql/sqlconnection.hpp>

#include <QObject>

extern std::unique_ptr<sql::db_sqlite> g_sqlite_ptr;

struct login_config
{
    QString username;
    QString password;
    bool password_saved;
    bool autologined;
};

class CLogin : public QObject
{
    Q_OBJECT
public:
    CLogin(QObject *parent = 0);

    ~CLogin();

    bool is_logined() const;

    login_config& config();

    Q_INVOKABLE bool login(const QString& username, const QString& password, bool savedpwd, bool autologin);

    void login();

private:
    bool m_logined;
    login_config m_config;
};
