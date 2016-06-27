import QtQuick 2.5
import QtQuick.Controls 1.4


TextArea {
    wrapMode: TextEdit.Wrap

    function typeText(newText) {
        insert(length, newText)
    }

    function clearAll() {
        remove(0, length)
    }

    function backspace() {
        remove(Math.max(length - 1, 0), length)
    }

    function newLine() {
        append("")
    }

    function cursorForward() {
        cursorPosition = Math.min(cursorPosition + 1, length)
    }

    function cursorBackward() {
        cursorPosition = Math.max(cursorPosition - 1, 0)
    }
}
