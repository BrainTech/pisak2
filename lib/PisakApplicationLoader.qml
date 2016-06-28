import QtQuick 2.5
import "main_screen"


/*!
    \qmltype PisakApplicationLoader
    \brief Loads and switches between various applications views.

    Switches between various applications and main screen view.
    Dynamically loads applications scripts.
*/
Loader {
    sourceComponent: __mainScreenComponent

    Component {
        id: __mainScreenComponent

        PisakMainScreen {
            onLoadApp: __loadApp(appFile)
        }
    }

    function __loadApp(appFile) {
        source = appFile
        item.exitApp.connect(__onAppExit)
    }

    function __onAppExit() {
        sourceComponent = __mainScreenComponent
    }
}
