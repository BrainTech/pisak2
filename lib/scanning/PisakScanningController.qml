import QtQuick 2.5
import Qt.labs.settings 1.0

/*!
    \qmltype PisakScanningController
    \brief Controller of the scanning.

    Controls transitions between different scanning groups,
    receives inputs from external devices and selects elements.
*/
Item {
    id: controller

    /*!
        \qmlproperty PisakScanningGroup PisakScanningController::mainGroup

        Top-level scanning group that should contain any other groups.
        Scanning starts in this group.

        The default value is \c null.
    */
    property PisakScanningGroup mainGroup: ({})

    /*!
        \qmlproperty bool PisakScanningController::running

        Indicates whether scanning is in progress.

        The default value is \c false.
    */
    property bool running: false

    // Connections below require target of a proper type that contains
    // the given signal so we put a placeholder PisakScanningGroup here:
    property PisakScanningGroup __currentGroup: PisakScanningGroup {}

    MouseArea {
        id: __mouseArea
        anchors.fill: parent
    }

    Component.onCompleted: {
        controller.__onInputMethodChange()
    }

    Connections {
        target: __currentGroup
        onActiveGroupChanged: __currentGroup = group
    }

    Keys.onPressed: {
        if (event.key === Qt.Key_Space) {
            controller.__onInputEvent()
        }
    }

    /*!
        \qmlmethod void PisakScanningController::startScanning()

        Starts scanning, beginning with the \l mainGroup.

        \sa stopScanning()
    */
    function startScanning() {
        if (!running) {
            __currentGroup = mainGroup
            __runCurrentGroup()
            running = true
        }
    }

    /*!
        \qmlmethod void PisakScanningController::stopScanning()

        Stops any running scanning.

        \sa startScanning()
    */
    function stopScanning() {
        if (running) {
            __stopCurrentGroup()
            running = false
        }
    }

    /*!
        \qmlmethod void PisakScanningController::goToGroup(PisakScanningGroup group)

        Stops any currently scanned group and moves to the given group.
    */
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
        var input = pisak.settings.input || "keyboard"
        if (input === "mouse-switch") {
            __mouseArea.onClicked = controller.__onInputEvent()
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
