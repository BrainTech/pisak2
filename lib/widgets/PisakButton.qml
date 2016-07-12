import QtQuick 2.5
import QtQuick.Layouts 1.2
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
    id: button

    visible: true

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
        __afterSelect()
    }

    function __afterSelect() {
        unwind(2)
    }

    Button {
        id: __button
        anchors.fill: parent

        style: ButtonStyle {
            label: PisakLabel {
                text: control.text
                color: control.__styleSpec.foreground
                font.family: control.__styleSpec.fontFamily
            }
            background: PisakRectangle {
                color: control.__styleSpec.background
                radius: control.__styleSpec.radius
                border.color: control.__styleSpec.border
                border.width: control.__styleSpec.borderWidth
            }
        }

        readonly property var __styleSpec: PisakStyle.skin[parent.styleClass][parent.state]

        onClicked: parent.clicked()
    }
}
