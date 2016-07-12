import QtQuick 2.5
import "../widgets"


PisakButton {
    id: button

    property PisakScanningGroup targetGroup: PisakScanningGroup {}

    property PisakScanningController controller: null

    Connections {
        target: targetGroup
        onStateChanged: __monitorTargetGroupState()
    }

    onTargetGroupChanged: __monitorTargetGroupState()

    onClicked: controller.goToGroup(targetGroup)

    function __monitorTargetGroupState() {
        if (targetGroup.state === "disabled") { button.state = "disabled" }
    }

    function __afterSelect() {}
}
