#include "login.h"

CLogin::CLogin(QObject *parent) : QObject(parent), m_logined(false), m_config()
{

}

CLogin::~CLogin()
{

}

bool CLogin::is_logined() const
{
    return m_logined;
}

login_config& CLogin::config()
{
    return m_config;
}

bool CLogin::login(const QString &username, const QString &password, bool savedpwd, bool autologin)
{
    m_config.username = username;
    if (savedpwd)
        m_config.password = password;
    else
        m_config.password.clear();
    m_config.password_saved = savedpwd;
    m_config.autologined = autologin;

    //ToDo.

    m_logined = true;
    return m_logined;
}

void CLogin::login()
{
    m_logined = true;
}

