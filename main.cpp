#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QSslSocket>

#include "appcore.h"
#include "cachnamfactory.h"

int main(int argc, char *argv[])
{
    qputenv("QT_QPA_NO_TEXT_HANDLES", "1");
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QCoreApplication::setOrganizationName("Azia");
    //QCoreApplication::setOrganizationDomain("mysoft.com"); //needed ios
    QCoreApplication::setApplicationName("AziaClient");

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.setNetworkAccessManagerFactory(new CachNAMFactory);

    qDebug() << QSslSocket::supportsSsl() << QSslSocket::sslLibraryVersionString() << QSslSocket::sslLibraryBuildVersionString();

    AppCore core;
    engine.rootContext()->setContextProperty("core", &core);
    engine.rootContext()->setContextProperty("user", &core.user);    
    engine.rootContext()->setContextProperty("basket", &core.basket);
    engine.rootContext()->setContextProperty("activeOrder", &core.activeOrder);
    engine.rootContext()->setContextProperty("shopsModel", &core.shopsModel);

    const QUrl url(QStringLiteral("qrc:/qml/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    engine.addImportPath(":/qml");
    engine.load(url);

    return app.exec();
}
