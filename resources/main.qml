import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import Qt.labs.platform 1.0

//import QtQuick.FreeVirtualKeyboard 1.0

ApplicationWindow  {
    width: Screen.width/2
    height: Screen.height/2
    visible: true
    title: qsTr("Keyboard example");


    TextField {
        id: defaultTextField
        placeholderText: "default"
    }

    Button
    {
        text: qsTr("OK");
        anchors.horizontalCenter: parent.horizontalCenter;
        anchors.bottom: parent.bottom;
    }
}
