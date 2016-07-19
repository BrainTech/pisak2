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

    property int activeBlinkInterval: 200

    function __doSelect() { clicked() }

    function __afterSelect() { unwind(2) }

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

                SequentialAnimation on color {
                    id: __animation
                    loops: Animation.Infinite
                    running: button.__activeAnimationRunning

                    readonly property var __style: control.__style["active"].feedbackAnimation

                    ColorAnimation {
                        from: __animation.__style.colorFrom
                        to: __animation.__style.colorTo
                        duration: button.activeBlinkInterval / 2
                    }

                    ColorAnimation {
                        from: __animation.__style.colorTo
                        to: __animation.__style.colorFrom
                        duration: button.activeBlinkInterval / 2
                    }
                }
            }
        }

        readonly property var __style: PisakStyle.skin[parent.styleClass]

        readonly property var __styleSpec: __style[parent.state]

        onClicked: parent.clicked()
   }
}
