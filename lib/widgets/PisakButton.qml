import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import ".."
import "../style"
import "../scanning"


/*!
    \qmltype PisakButton
    \brief Pisak button base class.

    Represents basic GUI element that can by styled easily.
*/
PisakScanningGroup {
    signal clicked()

    property alias text: __button.text

    /*!
        \qmlproperty string PisakButton::styleClass

        Name of the object that can be used by a style sheet to define its style properties.

        The default value is \c "button".
    */
    property string styleClass: "button"

    /*!
        \qmlmethod void PisakButton::select()

        Selects the button - emits the \c clicked signal.
    */
    function select() {
        state = "active"
        clicked()
        unwind()
    }

    /*!
        \qmlproperty PisakScanningGroup PisakButton::parentScanningGroup

        Group that the given button belongs to as one of its elements.

        The default value is \c null.
    */
    property var parentScanningGroup: ({})

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
