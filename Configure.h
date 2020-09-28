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
