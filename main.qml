import QtQuick 2.5
import QtQuick.Layouts 1.2
import QtQuick.Window 2.2
import "lib"
import "lib/scanning"
import "lib/widgets"


PisakMainWindow {
    title: qsTr("PISAK")
    width: Screen.width
    height: Screen.height
    visible: true
    visibility: "FullScreen"

    menuBar: PisakMenuBar {
        PisakMenu {
            title: qsTr("Plik")
            PisakMenuItem {}
        }
    }

    toolBar: PisakToolBar {
        RowLayout {
            anchors.fill: parent
            PisakToolButton {}
        }
    }

    statusBar: PisakStatusBar {
        RowLayout {
            anchors.fill: parent
            PisakLabel {
                text: qsTr("PISAK")
            }
        }
    }

    PisakApplicationLoader {}

}
