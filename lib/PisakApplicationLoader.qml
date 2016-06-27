import QtQuick 2.5
import "main_screen"

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
