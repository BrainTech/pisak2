import QtQuick 2.5
import "../media"

/*!
    \qmltype PisakScanningStrategy
    \brief Description of a scanning cycle.

    Strategy is an implementation of a scanning cycle and must be bind to
    some PisakScanningGroup.
*/
Item {
    id: main
    visible: false

    /*!
        \qmlproperty PisakScanningGroup PisakScanningStrategy::group

        Scanning group that the strategy is applied to.

        The default value is \c null.
    */
    property var group: ({})

    /*!
        \qmlproperty int PisakScanningStrategy::maxCycleCount

        Number of cycles without user input after which scanning leaves the group.

        The default value is \c 2.

        \sa groupExhausted
    */
    property int maxCycleCount: 2

    /*!
        \qmlproperty int PisakScanningStrategy::interval

        Scanning cycle interval - duration of focus staying on one element.
        Value is in miliseconds.

        The default value is \c 1000.
    */
    property int interval: 1000

    /*!
        \qmlproperty int PisakScanningStrategy::jitter

        Range (+/- jitter) of a random value to be added to the scanning interval
        at each scanning step.

        The default value is \c 0.

        \sa interval
    */
    property int jitter: 0

    /*!
        \qmlproperty int PisakScanningStrategy::startUpLag

        Number of miliseconds to wait before the scanning starts.

        The default value is \c 0.
    */
    property int startUpLag: 0

    /*!
        \qmlproperty bool PisakScanningStrategy::scanningSoundEnabled

        Indicates whether a sound effect should be played on each scanning cycle timeout.

        The default value is \c true.

        \sa scanningSoundName
    */
    property bool scanningSoundEnabled: true

    /*!
        \qmlproperty string PisakScanningStrategy::scanningSoundName

        Name of sound that should be played on each scanning cycle timeout.

        The default value is \c "scanningSound".

        \sa scanningSoundEnabled
    */
    property string scanningSoundName: "scanningSound"

    /*!
        \qmlproperty string PisakScanningStrategy::sampling

        Sampling type, so far only "order" available. In future possibly also something like:
        "random", "random with replacement" etc. Describes how to pick next element to be scanned.

        The default value is \c "order".
    */
    property string sampling: "order"

    /*!
        \qmlproperty bool PisakScanningStrategy::running

        An aliased property that indicates whether the scanning cycle is on.

        The default value is \c false.
    */
    property alias running: __timer.running

    // TODO: list of indices of all the elements, grouped into scanned units, for example into rows, columns etc.
    // Each index must correspond to an item on the list of the group's elements:
    // property var scanningUnits: []

    property alias __repeatableTimer: __timer.repeat

    property int __cycleIdx: 0
    property var __currentElement: ({})
    property int __currentElementIdx: -1
    property var __elements: group.elements
    property int __elementCount: __elements.length

    PisakSoundEffect {
        id: __scanningSound
        source: pisak.resources.getSoundPath(scanningSoundName)
    }

    Timer {
        id: __timer
        interval: (__repeatableTimer) ? interval:__calculateTimerInterval()
        repeat: jitter == 0
        onTriggered: main.__onCycleTimeout()
        triggeredOnStart: false
    }

    Timer {
        id: __startUpTimer
        interval: startUpLag
        repeat: false
        onTriggered: __timer.start()
        triggeredOnStart: false
    }

    /*!
        \qmlmethod void PisakScanningStrategy::startCycle()

        Start the scanning cycle.

        \sa stopCycle()
    */
    function startCycle() {
        group.state = "focusable"
        if (startUpLag > 0) {
            __startUpTimer.start()
        } else { __timer.start() }
    }

    /*!
        \qmlmethod void PisakScanningStrategy::stopCycle()

        Stops the scanning cycle.

        \sa startCycle()
    */
    function stopCycle() {
        __timer.stop()
        group.state = "normal"
        __currentElementIdx = -1
        __cycleIdx = 0
    }

    /*!
        \qmlmethod void PisakScanningStrategy::pauseCycle()

        Pauses the scanning cycle. Scanning is frozen in its current state.

        \sa restartCycle()
    */
    function pauseCycle() {
        running = false
    }

    /*!
        \qmlmethod void PisakScanningStrategy::restartCycle()

        Restarts the scanning cycle that has been paused.
        If the scanning was already running then it does nothing.

        \sa pauseCycle()
    */
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
        __timer.interval = __calculateTimerInterval()
        running = true
    }

    function __playScanningSound() {
        __scanningSound.play()
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
