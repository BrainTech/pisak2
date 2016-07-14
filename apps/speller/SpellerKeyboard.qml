import QtQuick 2.5
import QtQuick.Layouts 1.2
import "../../lib/scanning"


ColumnLayout {
    id: keyboard
    spacing: 5

    property SpellerTextArea textArea: ({})

    property PisakScanningGroup menuGroup: null

    readonly property PisakScanningGroup mainScanningGroup: __mainScanningGroup

    property var defaultCharSet: [["q", "w", "e", "r", "t", "y", "u"],
                                    ["i", "o", "p", "a", "s", "d", "f"],
                                    ["g", "h", "j", "k", "l", "z", "x"],
                                    [".", " ", "c", "v", "b", "n", "m"]]

    property var __currentCharSet: defaultCharSet

    property var __keyboardModel: null

    readonly property int rows: __currentCharSet.length

    property var __scanningGroups: new Array(0)

    property var __rows: new Array(0)

    property bool __uppercase: false

    property bool __backToDefaultCharSetOnKeySelected: false
    property bool __backToDefaultCharSetOnUnwind: false

    PisakScanningGroup {
        id: __mainScanningGroup
        unwind: __keyboardUnwind

        onUnwindedFromSubgroup: {
            if (__backToDefaultCharSetOnKeySelected) {
                __backToDefaultCharSetOnKeySelected = false
                setDefaultCharSet()
            }
        }

        function __keyboardUnwind(levels) {
            if (__backToDefaultCharSetOnUnwind) {
                __backToDefaultCharSetOnUnwind = false
                setDefaultCharSet()
                startScanning()
            } else { __unwind(levels) }
        }
    }

    Repeater {
        model: __keyboardModel

        RowLayout {
            id: row
            Layout.alignment: Qt.AlignHCenter

            Repeater {
                model: modelData

                SpellerKey {
                    id: key
                    text: modelData
                    onClicked: { keyboard.__selectKey(key) }
                }
            }

            PisakScanningGroup {
                id: group
                elements: row.children
            }

            Component.onCompleted: {
                if (index === 0) {
                    keyboard.__scanningGroups.push(keyboard.menuGroup)
                }
                keyboard.__rows.push(row)
                keyboard.__scanningGroups.push(group)
            }
        }
    }

    Component.onCompleted: {
        __mainScanningGroup.elements = __scanningGroups
    }

    on__CurrentCharSetChanged: {
        __scanningGroups = new Array(0)
        __rows = new Array(0)
        __keyboardModel = __currentCharSet
        __mainScanningGroup.elements = __scanningGroups
    }

    function setCharSet(newCharSet) {
        __uppercase = false
        if (newCharSet === __currentCharSet) { newCharSet = null }
        __backToDefaultCharSetOnUnwind = newCharSet !== defaultCharSet
        __currentCharSet = newCharSet || defaultCharSet
    }

    function setDefaultCharSet() {
        setCharSet(defaultCharSet)
    }

    function setUpperCase() {
        if (!__uppercase) {
            setCharSet(__currentCharSet.map(function(row) {
                return row.map(function(x){ return x.toUpperCase() }) }))
            __uppercase = true
        } else {
            setDefaultCharSet()
        }
    }

    function __selectKey(key) {
        textArea.typeText(key.text)
        if (__currentCharSet !== defaultCharSet) { __backToDefaultCharSetOnKeySelected = true }
    }
}
