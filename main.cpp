#include <QGuiApplication>
#include <QLoggingCategory> //  For QLoggingCategory::setFilterRules(QStringLiteral("qt.qml.binding.removal.info=true"));
#include <QQmlApplicationEngine>

int main(int argc, char* argv[])
{
    qputenv("QT_DEBUG_PLUGINS", QByteArray("1"));
    qputenv("QT_IM_MODULE", QByteArray("openvirtualkeyboard:animateRollout"));

    // Only for debugging purpouses. For more details - look through
    // https://doc.qt.io/qt-5/qtqml-syntax-propertybinding.html This allows to verify, that some
    // bindings were merely assigned to an constants expressions. Sometimes assignment of the
    // constant instead of binding can cause hard-to-debug-bugs. For some places- it's normal
    // practise.
    QLoggingCategory::setFilterRules(QStringLiteral("qt.qml.binding.removal.info=true"));

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.addImportPath("./plugins");

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreated,
        &app,
        [url](QObject* obj, const QUrl& objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
