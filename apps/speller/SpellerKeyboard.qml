import QtQuick 2.5
import QtQuick.Layouts 1.2
import "../../lib/scanning"


ColumnLayout {
    id: keyboard
    spacing: 5

    property SpellerTextArea textArea: ({})

    property string charSet: "default"

    property var charSets: {"default": [["q", "w", "e", "r", "t", "y", "u"],
                                        ["i", "o", "p", "a", "s", "d", "f"],
                                        ["g", "h", "j", "k", "l", "z", "x"],
                                        [".", " ", "c", "v", "b", "n", "m"]]}

    readonly property int rows: __currentCharSet.length

    readonly property PisakScanningGroup mainScanningGroup: __mainScanningGroup

    readonly property var __currentCharSet: charSets[charSet]

    property var __scanningGroups: new Array(0)

    property var __rows: new Array(0)

    Repeater {
        model: rows

        RowLayout {
            id: row
            Layout.alignment: Qt.AlignHCenter

            property int rowIndex: index

            Repeater {
                model: __currentCharSet[rowIndex].length

                SpellerKey {
                    id: key
                    text: keyboard.__currentCharSet[rowIndex][index]

                    onClicked: keyboard.textArea.typeText(text)
                }
            }

            PisakScanningGroup {
                id: group
                elements: row.children
            }

            Component.onCompleted: {
                keyboard.__rows.push(row)
                keyboard.__scanningGroups.push(group)
            }
        }
    }

    PisakScanningGroup {
        id: __mainScanningGroup
    }

    Component.onCompleted: {
        __mainScanningGroup.elements = __scanningGroups
    }

    onCharSetChanged: {
        // static keyboard layout
        for(var rowIdx = 0; rowIdx < __rows.length; rowIdx++) {
            for(var colIdx = 0; colIdx < __rows[rowIdx].length; colIdx++) {
                if (rowIdx < __currentCharSet.length && colIdx < __currentCharSet[rowIdx].length) {
                    __rows[rowIdx][colIdx].text = __currentCharSet[rowIdx][colIdx]
                }
            }
        }
    }

    function upperCase() {}

    function lowerCase() {}

    function altGr() {}
}
