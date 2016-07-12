pragma Singleton

import QtQuick 2.5
import QtQuick.Window 2.2


QtObject {
    readonly property int __refWindowWidth: Screen.width
    readonly property int __refWindowHeight: Screen.height
    readonly property int __refFontPixelSize: Math.min(__refWindowHeight,
                                                  __refWindowWidth) * 0.035
    readonly property int __minFontPixelSize: Math.min(__refWindowHeight,
                                                       __refWindowWidth) * 0.015

    property int windowWidth: __refWindowWidth
    property int windowHeight: __refWindowHeight

    property int fontPixelSize: Math.max(Math.min(windowWidth/__refWindowWidth,
                                         windowHeight/__refWindowHeight) * __refFontPixelSize,
                                         __minFontPixelSize)
}
