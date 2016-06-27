import QtQuick 2.5
import "../media"

/*!
    \qmltype PisakScanningStrategy
    \brief Description of a scanning cycle

    Strategy it an implementation of a scanning cycle and must be bind to some PisakScanningGroup.
*/
Item {
    id: main
    visible: false

    property var group: ({})

    property int maxCycleCount: 2
    property int interval: 1000
    property int jitter: 0
    property bool scanningSoundEnabled: true
    property url scanningSoundFile: "scanningSound"

    // sampling type, so far only "order" available. In future possibly also something like:
    // "random", "random with replacement" etc. Describes how to pick next element to be scanned.
    // Maybe should be implemented by subclasses:
    property string sampling: "order"

    property alias running: timer.running

    // TODO: list of indices of all the elements, grouped into scanned units, for example into rows, columns etc.
    // Each index must correspond to an item on the list of the group's elements:
    // property var scanningUnits: []

    property alias __repeatableTimer: timer.repeat

    property int __cycleIdx: 0
    property var __currentElement: ({})
    property int __currentElementIdx: -1
    property var __elements: group.elements
    property int __elementCount: __elements.length

    PisakSoundEffect {
        id: scanningSound
        source: pisak.resources.getSoundPath(scanningSoundFile)
    }

    Timer {
        id: timer
        interval: (__repeatableTimer) ? interval:__calculateTimerInterval()
        repeat: jitter == 0
        onTriggered: main.__onCycleTimeout()
        triggeredOnStart: false
    }

    function startCycle() {
        group.state = "focusable"
        timer.start()
    }

    function stopCycle() {
        timer.stop()
        group.state = "normal"
        __currentElementIdx = -1
        __cycleIdx = 0
    }

    function pauseCycle() {
        running = false
    }

    function restartCycle() {
        running = true
    }

    function getCurrentElement() {
        return __currentElement
    }

    function __calculateTimerInterval() {
        return interval + Math.floor(Math.random() * (2*jitter + 1)) - jitter
    }

    function __continueCycle() {
        timer.interval = __calculateTimerInterval()
        running = true
    }

    function __playScanningSound() {
        scanningSound.play()
    }

    function __onCycleTimeout() {
        if (__currentElementIdx >= 0) {
            __currentElement.state = "focusable"
        }
        __currentElement = __exposeNextElement()
        if (__currentElement) {
            if (scanningSoundEnabled) { __playScanningSound() }
            __currentElement.state = "focus"
            if (!__repeatableTimer) {
                __continueCycle()
            }
        }
    }

    function __getNextElementIdx() {
        var ret
        switch (sampling) {
            case "order":
            default:
                ret = (__currentElementIdx + 1) % __elementCount
                break
        }
        return ret
    }

    function __exposeNextElement() {
        if (__currentElementIdx == __elementCount - 1) {
            if (__cycleIdx == maxCycleCount - 1) {
                stopCycle()
                group.unwind()
                return
            } else { __cycleIdx += 1 }
        }
        __currentElementIdx = __getNextElementIdx()
        return __elements[__currentElementIdx]
    }
}
