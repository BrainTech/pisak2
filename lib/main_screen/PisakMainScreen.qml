import QtQuick 2.5
import QtQuick.Layouts 1.2
import ".."
import "../widgets"
import "../scanning"


PisakApplication {
    id: main

    signal loadApp(url appFile)

    Component.onCompleted: {
        scanningController.startScanning()
    }

    PisakScanningController {
        id: scanningController
        mainGroup: mainScanningGroup
    }

    PisakScanningGroup {
        id: mainScanningGroup
        elements: [group1, group2]
    }

    PisakScanningGroup {
        id: group1
        elements: [button1, button2]
    }

    PisakScanningGroup {
        id: group2
        elements: [button3, button4]
    }

    GridLayout {
        anchors.fill: parent
        columns: 2

        PisakButtonMainScreen {
            id: button1
            text: qsTr("Aplikacja1")
            onClicked: loadApp("Aplikacja1.qml")
        }

        PisakButtonMainScreen {
            id: button2
            text: qsTr("Aplikacja2")
            onClicked: loadApp("Aplikacja2.qml")
        }

        PisakButtonMainScreen {
            id: button3
            text: qsTr("Aplikacja3")
            onClicked: loadApp("Aplikacja3.qml")
        }

        PisakButtonMainScreen {
            id: button4
            text: qsTr("Aplikacja4")
            onClicked: loadApp("Aplikacja4.qml")
        }

    }

}
