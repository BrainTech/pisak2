import QtQuick 2.5
import QtQuick.Controls 1.4
import ".."
import "../style"


/*!
    \qmltype PisakTextArea
    \brief Pisak text area base class.

    Displays multi-line editable text.
*/
TextArea {
    id:main

    wrapMode: TextEdit.Wrap
    activeFocusOnPress: false
    font.pixelSize: PisakGlobals.fontPixelSize

    property string styleClass: "textArea"

    readonly property var __styleSpec: PisakStyle.skin[styleClass]

    Rectangle {
        x: main.cursorRectangle.x
        y: main.cursorRectangle.y
        width: main.cursorRectangle.width
        height: main.cursorRectangle.height
        color: parent.__styleSpec.cursorColor

        OpacityAnimator on opacity{
            loops: Animation.Infinite
            from: 0
            to: 1
            duration: 500
        }
    }

    onWidthChanged: __onResized()
    onHeightChanged: __onResized()

    function __onResized() {
        if (cursorRectangle.y > (y + height)) {
            flickableItem.contentY = cursorRectangle.y - height*0.8
        }
    }

    /*!
        \qmlmethod void PisakTextArea::typeText(string text)

        Inserts given text to the current text buffer in the current cursor position.
    */
    function typeText(newText) {
        insert(cursorPosition, newText)
    }

    /*!
        \qmlmethod void PisakTextArea::clearAll()

        Removes all text.
    */
    function clearAll() {
        remove(0, length)
    }

    /*!
        \qmlmethod void PisakTextArea::backspace()

        Removes the last character starting with the current cursor position.
    */
    function backspace() {
        remove(Math.max(cursorPosition - 1, 0), cursorPosition)
    }

    /*!
        \qmlmethod void PisakTextArea::newLine()

        Moves to the new line.
    */
    function newLine() {
        append("")
    }

    /*!
        \qmlmethod void PisakTextArea::cursorForward()

        Moves cursor one position forward.
    */
    function cursorForward() {
        cursorPosition = Math.min(cursorPosition + 1, length)
    }

    /*!
        \qmlmethod void PisakTextArea::cursorBackward()

        Moves cursor one position backward.
    */
    function cursorBackward() {
        cursorPosition = Math.max(cursorPosition - 1, 0)
    }
}
