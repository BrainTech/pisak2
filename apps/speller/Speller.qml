import QtQuick 2.5
import QtQuick.Layouts 1.2
import QtQuick.Window 2.2
import "../../lib"
import "../../lib/widgets"
import "../../lib/scanning"


PisakMainWindow {
    id: main
    visible: true
    width: Screen.width * 0.7
    height: Screen.height * 0.7

    Component.onCompleted: scanningController.startScanning()

    PisakApplication {
        id: app
        anchors.fill: parent

        onExitApp: main.close()

        PisakScanningController {
            id: scanningController
            mainGroup: mainScanningGroup
        }

        PisakScanningGroup {
            id: mainScanningGroup
            elements: [mainMenuGroup, predictionGroup, keyboard.mainScanningGroup]
        }

        PisakScanningGroup {
            id: mainMenuGroup
            elements: mainMenuPanel.children
        }

        PisakScanningGroup {
            id: predictionGroup
            elements: predictionPanel.children
        }

        RowLayout {
            width: parent.width
            height: parent.height
            spacing: 5

            ColumnLayout {
                id: mainMenuPanel
                Layout.alignment: Qt.AlignVCenter
                spacing: 5

                SpellerButton {
                    id: buttonClearAll
                    text: qsTr("WYCZYŚĆ")
                    onClicked: textArea.clearAll()
                }

                SpellerButton {
                    id: buttonBackspace
                    text: qsTr("SKASUJ OSTATNI")
                    onClicked: textArea.backspace()
                }

                SpellerButton {
                    id: buttonNewLine
                    text: qsTr("ENTER")
                    onClicked: textArea.newLine()
                }

                SpellerButton {
                    id: buttonCursorForward
                    text: qsTr("DO PRZODU")
                    onClicked: textArea.cursorForward()
                }

                SpellerButton {
                    id: buttonCursorBackward
                    text: qsTr("DO TYŁU")
                    onClicked: textArea.cursorBackward()
                }

                SpellerButton {
                    id: buttonExit
                    text: qsTr("WYJŚCIE")
                    onClicked: app.exitApp()
                }

                SpellerButton {
                    id: buttonPrint
                    text: qsTr("DRUKUJ")
                }

                SpellerButton {
                    id: buttonSave
                    text: qsTr("ZAPISZ")
                }
            }

            ColumnLayout {
                id: predictionPanel
                Layout.alignment: Qt.AlignVCenter
                spacing: 5

                Repeater {
                    model: 8
                    SpellerButton {
                        text: qsTr("PREDYKCJA %1").arg(index+1)
                    }
                }
            }

            ColumnLayout {
                id: inputAreaPanel
                Layout.alignment: Qt.AlignVCenter
                spacing: 5

                SpellerTextArea {
                    id: textArea
                    Layout.alignment: Qt.AlignHCenter
                }

                SpellerKeyboard {
                    id: keyboard
                    textArea: textArea
                    Layout.alignment: Qt.AlignHCenter
                }
            }
        }
    }
}
