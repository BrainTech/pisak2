import QtQuick.Controls 1.4
import "."


/*!
    \qmltype PisakMainWindow
    \brief Main window for Pisak.

    Provides main window for a program with handling of menu, toolbar, statusbar etc
*/
ApplicationWindow {
    onWidthChanged: PisakGlobals.windowWidth = width
    onHeightChanged: PisakGlobals.windowHeight = height
}
