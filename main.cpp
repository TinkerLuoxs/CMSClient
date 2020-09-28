#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickView>
#include <QQuickItem>
#include "login.h"

std::unique_ptr<sql::db_sqlite> g_sqlite_ptr;

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    QString dbfile = QCoreApplication::applicationDirPath();
    dbfile += "/CMS_ClientConfigure.db";
    g_sqlite_ptr = std::make_unique<sql::db_sqlite>(dbfile.toStdString());

    int found = 0;
    g_sqlite_ptr->execute("SELECT 1 FROM user", [&found](auto, auto)
    {
       found = 1;
    });

    if (found == 0)
    {
        g_sqlite_ptr->execute("CREATE TABLE user(username TEXT, password TEXT, password_saved INTEGET, autologined INTEGET)");
        g_sqlite_ptr->execute("INSERT INTO user VALUES('','',0,0)");
    }

    CLogin login;
    login_config& config = login.config();
    g_sqlite_ptr->execute("SELECT username, password, password_saved, autologined FROM user", [&config](auto, auto v)
    {
        config.username = v[0];
        config.password = v[1];
        config.password_saved = atoi(v[2]) > 0;
        config.autologined = atoi(v[3]) > 0;
    });

    if (config.autologined)
        login.login();

    if (!login.is_logined())
    {
        QQuickView viewer;
        viewer.setSource(QUrl("qrc:/qml/Login.qml"));
        QObject::connect(viewer.engine(), SIGNAL(quit()), &viewer, SLOT(close()));

        QQuickItem *rootObject = viewer.rootObject();
        rootObject->setProperty("username", config.username);
        rootObject->setProperty("password", config.password);
        rootObject->setProperty("passwordSaved", config.password_saved);
        rootObject->setProperty("autoLogined", config.autologined);

        QMetaObject::invokeMethod(rootObject, "init");

        viewer.setFlags(Qt::MSWindowsFixedSizeDialogHint | Qt::FramelessWindowHint);
        viewer.rootContext()->setContextProperty("loginWindow", &viewer);
        viewer.rootContext()->setContextProperty("cppLogin", &login);
        viewer.show();
        app.exec();
    }

    if (login.is_logined())
    {
        QString sqlstr = QString("UPDATE user SET username='%1', password='%2', password_saved=%3, autologined=%4")
                .arg(config.username).arg(config.password).arg(config.password_saved).arg(config.autologined);
        g_sqlite_ptr->execute(sqlstr.toStdString());
    }
    else
        return -1;

    QQmlApplicationEngine engine;
    engine.load(QUrl(QLatin1String("qrc:/qml/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
