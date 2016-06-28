import QtQuick 2.5


/*!
    \qmltype PisakApplication
    \brief Base class for any Pisak application.

    To create new Pisak-based application one should use this
    item as a top-level container. It provides a signal that
    allows to close an application.
*/
Item {
    /*!
        \qmlsignal PisakApplication::exitApp()

        Signal should be emitted when one wants to exit the application.
    */
    signal exitApp()
}
