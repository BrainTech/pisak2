import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import ".."
import "../style"
import "../scanning"


PisakScanningGroup {
    signal clicked()

    property alias text: __button.text

    property string styleClass: "button"

    function select() {
        state = "active"
        clicked()
        unwind()
    }

    Button {
        id: __button

        style: ButtonStyle {
            label: PisakLabel {
                text: control.text
                color: __styleSpec.foreground
                font.family: __styleSpec.fontFamily
                font.pixelSize: __styleSpec.fontPixelSize
            }
            background: PisakRectangle {
                color: __styleSpec.background
                radius: __styleSpec.radius
                border.color: __styleSpec.border
                border.width: __styleSpec.borderWidth
            }
        }

        readonly property var __styleSpec: PisakStyle.skin[parent.styleClass][parent.state]

        onClicked: parent.clicked()
    }
}
