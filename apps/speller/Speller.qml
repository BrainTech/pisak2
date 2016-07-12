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
            state: "disabled"
            elements: predictionPanel.children
        }

        PisakScanningGroup {
            id: keyboardMenuGroup
            elements: keyboardMenu.children
        }

        RowLayout {
            width: parent.width
            height: parent.height
            spacing: 5

            ColumnLayout {
                id: mainMenuPanel
                Layout.alignment: Qt.AlignVCenter
                spacing: 5

                SpellerButtonScanningTeleporter {
                    id: buttonFromMainMenuToKeyboard
                    text: qsTr("LITERY")
                    controller: scanningController
                    targetGroup: keyboard.mainScanningGroup
                }

                SpellerButtonScanningTeleporter {
                    id: buttonFromMainMenuToPrediction
                    text: qsTr("PREDYKCJA")
                    controller: scanningController
                    targetGroup: predictionGroup
                }

                SpellerButton {
                    id: buttonClearAll
                    text: qsTr("WYCZYŚĆ")
                    onClicked: textArea.clearAll()
                }

                SpellerButton {
                    id: buttonSave
                    text: qsTr("ZAPISZ")
                    state: "disabled"
                }

                SpellerButton {
                    id: buttonLoad
                    text: qsTr("WCZYTAJ")
                    state: "disabled"
                }

                SpellerButton {
                    id: buttonRead
                    text: qsTr("PRZECZYTAJ")
                    state: "disabled"
                }

                SpellerButton {
                    id: buttonSend
                    text: qsTr("WYŚLIJ")
                    state: "disabled"
                }

                SpellerButton {
                    id: buttonPrint
                    text: qsTr("DRUKUJ")
                    state: "disabled"
                }

                SpellerButton {
                    id: buttonExit
                    text: qsTr("WYJŚCIE")
                    onClicked: app.exitApp()
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

                RowLayout {
                    id: keyboardMenu
                    Layout.alignment: Qt.AlignHCenter

                    SpellerSquareButtonScanningTeleporter {
                        id: buttonFromKeyboardToPrediction
                        text: qsTr("PREDYKCJA")
                        controller: scanningController
                        targetGroup: predictionGroup
                    }

                    SpellerSquareButton {
                        id: buttonUppercaseChars
                        text: qsTr("DUŻE LITERY")
                    }

                    SpellerSquareButton {
                        id: buttonPolishChars
                        text: qsTr("POLSKIE ZNAKI")
                        state: "disabled"
                    }

                    SpellerSquareButton {
                        id: buttonSpecialChars
                        text: qsTr("ZNAKI SPECJALNE")
                        state: "disabled"
                    }

                    SpellerSquareButton {
                        id: buttonBackspace
                        text: qsTr("SKASUJ OSTATNI")
                        onClicked: textArea.backspace()
                    }

                    SpellerSquareButton {
                        id: buttonNewLine
                        text: qsTr("ENTER")
                        onClicked: textArea.newLine()
                    }

                    SpellerSquareButton {
                        id: buttonUndo
                        text: qsTr("COFNIJ")
                        state: "disabled"
                    }

                    SpellerSquareButton {
                        id: buttonCursorForward
                        text: qsTr("DO PRZODU")
                        onClicked: textArea.cursorForward()
                    }

                    SpellerSquareButton {
                        id: buttonCursorBackward
                        text: qsTr("DO TYŁU")
                        onClicked: textArea.cursorBackward()
                    }

                    SpellerSquareButton {
                        id: buttonCursorUp
                        text: qsTr("DO GÓRY")
                        state: "disabled"
                    }

                    SpellerSquareButton {
                        id: buttonCursorDown
                        text: qsTr("W DÓŁ")
                        state: "disabled"
                    }

                    SpellerSquareButtonScanningTeleporter {
                        id: buttonFromKeyboardToMainMenu
                        text: qsTr("NARZĘDZIA")
                        controller: scanningController
                        targetGroup: mainMenuGroup
                    }
                }

                SpellerKeyboard {
                    id: keyboard
                    textArea: textArea
                    Layout.alignment: Qt.AlignHCenter
                    menuGroup: keyboardMenuGroup
                }
            }
        }
    }
}
