import QtQuick 2.5
import Qt.labs.settings 1.0

/*!
    \qmltype PisakScanningController
    \brief Controller of the scanning

    Controls transitions between different scanning groups,
    receives inputs from external devices and selects elements.
*/
Item {
    id: controller

    property PisakScanningGroup mainGroup: ({})

    property bool running: false

    // Connections below require target of a proper type that contains
    // the given signal so we put a placeholder PisakScanningGroup here:
    property PisakScanningGroup __currentGroup: PisakScanningGroup {}

    Component.onCompleted: {
        controller.__onInputMethodChange()
    }

    Connections {
        target: __currentGroup
        onActiveGroupChanged: __currentGroup = group
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
    }

    Keys.onPressed: {
        if (event.key === Qt.Key_Space) {
            controller.__onInputEvent()
        }
    }

    function startScanning() {
        if (!running) {
            __currentGroup = mainGroup
            __runCurrentGroup()
            running = true
        }
    }

    function stopScanning() {
        if (running) {
            __stopCurrentGroup()
            running = false
        }
    }

    function goToGroup(group) {
        __stopCurrentGroup()
        __currentGroup = group
        __runCurrentGroup()
    }

    function __runCurrentGroup() {
        __currentGroup.startScanning()
    }

    function __stopCurrentGroup() {
        __currentGroup.stopScanning()
    }

    function __onInputMethodChange() {
        var input = pisak.settings.input
        if (input === "mouse-switch") {
            mouseArea.onClicked = controller.__onInputEvent()
        } else if (input === "keyboard") {
            controller.focus = true
        }
    }

    function __onInputEvent() {
        if (running) {
            __currentGroup.onInputEvent()
        }
    }
}
