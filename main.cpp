#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QSslSocket>
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QJsonDocument>
#include <QJsonArray>
#include <QJsonObject>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    QCoreApplication::setOrganizationName("Azia");
    //QCoreApplication::setOrganizationDomain("mysoft.com"); //needed ios
    QCoreApplication::setApplicationName("AziaClient");

    qDebug() << QSslSocket::supportsSsl() << QSslSocket::sslLibraryVersionString() << QSslSocket::sslLibraryBuildVersionString();

    qmlRegisterSingletonType(QUrl("qrc:qml/Data/User.qml"), "AziaData", 1, 0, "User");
    qmlRegisterSingletonType(QUrl("qrc:qml/Data/MenuItems.qml"), "AziaData", 1, 0, "MenuItems");
    qmlRegisterSingletonType(QUrl("qrc:qml/Data/Basket.qml"), "AziaData", 1, 0, "Basket");
    qmlRegisterSingletonType(QUrl("qrc:qml/Data/Events.qml"), "AziaData", 1, 0, "Events");

    QNetworkAccessManager manager;
    QNetworkRequest req(QUrl("https://78.24.216.174/aziaclient/menu"));
    QNetworkReply *reply = manager.get(req);
    reply->ignoreSslErrors();
    QObject::connect(reply, &QNetworkReply::finished, [&]() {
        if(reply->error() == QNetworkReply::NoError) {
            QByteArray arr = reply->readAll();
            QJsonDocument doc = QJsonDocument::fromJson(arr);
            QJsonArray menu = doc.array();
            qDebug() << menu.size();
            qDebug() << menu.at(0);

        } else {
            qDebug() << "error:" << reply->errorString();
        }
    });


    const QUrl url(QStringLiteral("qrc:/qml/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    engine.addImportPath(":/");
    engine.addImportPath(":/qml");
    engine.load(url);

    return app.exec();
}
