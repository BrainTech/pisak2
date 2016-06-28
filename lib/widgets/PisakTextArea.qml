import QtQuick 2.5
import QtQuick.Controls 1.4


/*!
    \qmltype PisakTextArea
    \brief Pisak text area base class.

    Displays multi-line editable text.
*/
TextArea {
    wrapMode: TextEdit.Wrap

    /*!
        \qmlmethod void PisakTextArea::typeText(string text)

        Appends given text to the current text buffer.
    */
    function typeText(newText) {
        insert(length, newText)
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

        Removes the last character.
    */
    function backspace() {
        remove(Math.max(length - 1, 0), length)
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
