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

    Component.onCompleted: {
        scanningController.startScanning()
    }

    PisakScanningController {
        id: scanningController
        mainGroup: mainScanningGroup
    }

    PisakScanningGroup {
        id: mainScanningGroup
        elements: [segment1Group, segment2Group, segment3Group]
    }

    PisakScanningGroup {
        id: segment1Group
        elements: [col1Group, col2Group]
    }

    PisakScanningGroup {
        id: segment2Group
        elements: [col3Group, col4Group]
    }

    PisakScanningGroup {
        id: segment3Group
        elements: [col5Group, col6Group]
    }

    PisakScanningGroup {
        id: col1Group
        elements: col1.children
    }

    PisakScanningGroup {
        id: col2Group
        elements: col2.children
    }

    PisakScanningGroup {
        id: col3Group
        elements: col3.children
    }

    PisakScanningGroup {
        id: col4Group
        elements: col4.children
    }

    PisakScanningGroup {
        id: col5Group
        elements: col5.children
    }

    PisakScanningGroup {
        id: col6Group
        elements: col6.children
    }


    RowLayout {
        width: parent.width
        height: parent.height
        spacing: 20
        RowLayout {
            ColumnLayout {
                id: col1
                Repeater {
                    model: 5
                    PisakButton {
                        Layout.minimumHeight: 50
                        Layout.minimumWidth: 150
                        text: qsTr("1_1_" + (index+1))
                        onClicked: console.log(text)
                    }
                }
            }
            ColumnLayout {
                id: col2
                Repeater {
                    model: 5
                    PisakButton {
                        Layout.minimumHeight: 50
                        Layout.minimumWidth: 150
                        text: qsTr("1_2_" + (index+1))
                        onClicked: console.log(text)
                    }
                }
            }
        }
        RowLayout {
            ColumnLayout {
                id: col3
                Repeater {
                    model: 5
                    PisakButton {
                        Layout.minimumHeight: 50
                        Layout.minimumWidth: 150
                        text: qsTr("2_1_" + (index+1))
                        onClicked: console.log(text)
                    }
                }
            }
            ColumnLayout {
                id: col4
                Repeater {
                    model: 5
                    PisakButton {
                        Layout.minimumHeight: 50
                        Layout.minimumWidth: 150
                        text: qsTr("2_2_" + (index+1))
                        onClicked: console.log(text)
                    }
                }
            }
        }
        RowLayout {
            ColumnLayout {
                id: col5
                Repeater {
                    model: 5
                    PisakButton {
                        Layout.minimumHeight: 50
                        Layout.minimumWidth: 150
                        text: qsTr("3_1_" + (index+1))
                        onClicked: console.log(text)
                    }
                }
            }
            ColumnLayout {
                id: col6
                Repeater {
                    model: 5
                    PisakButton {
                        Layout.minimumHeight: 50
                        Layout.minimumWidth: 150
                        text: qsTr("3_2_" + (index+1))
                        onClicked: console.log(text)
                    }
                }
            }
        }
    }
}
