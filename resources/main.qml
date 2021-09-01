import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import Qt.labs.platform 1.0

//import QtQuick.FreeVirtualKeyboard 1.0

ApplicationWindow  {
    width: Screen.width/3
    height: Screen.height/3
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
        onClicked: popup.open();
    }

    Popup {
        id: popup
        x: 100
        y: 100
        width: 200
        height: 300
        modal: false
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent

        TextField {
            id: popupField
            placeholderText: "default"
        }

        Button
        {
            text: qsTr("OK");
            anchors.horizontalCenter: parent.horizontalCenter;
            anchors.bottom: parent.bottom;
            onClicked: innerPopup.open();
        }

        Popup {
            id: innerPopup
            x: 300
            y: 300
            width: 200
            height: 300
            modal: true
            focus: true
            closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent

            TextField {
                id: innerField
                placeholderText: "default"
            }
        }
    }
}
