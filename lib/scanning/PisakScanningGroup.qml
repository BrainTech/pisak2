import QtQuick 2.5
import "../media"

/*!
    \qmltype PisakScanningGroup
    \brief Single scanning group that can contain multiple elements

    Groups together elements that are somehow related to each other or have
    something in common (but not necessarily are placed next to each other in the graphical layout)
    and should be scanned within the same scanning cycle.
*/
Item {
    id: main
    visible: false

    signal activeGroupChanged(var group)

    state: "normal"

    states: [
        State {
          name: "disabled"
        },
        State {
            name: "normal"
        },
        State {
            name: "focus"
        },
        State {
            name: "focusable"
        },
        State {
            name: "active"
        }
    ]

    property string __state: ((parentScanningGroup !== null) ? parentScanningGroup.state : "normal") || "normal"

    on__StateChanged: { if (__state !== "active" && state !== "disabled") { state = __state } }

    property var validElements: new Array(0)

    property int validElementCount: validElements.length

    property int activeFeedbackDuration: 1000

    property int activeFeedbackBlinkInterval: 200

    /*!
        \qmlproperty string PisakScanningGroup::soundName

        Name of a sound effect that should represent the group and be played on demand.

        The default value is \c "".
    */
    property string soundName: ""

    /*!
        \qmlproperty var PisakScanningGroup::elements

        List containing elements belonging to the group. Each element must be scannable.

        The default value is the empty list.

        \sa isScannable
    */
    property var elements: new Array(0)

    /*!
        \qmlproperty PisakScanningGroup PisakScanningGroup::parentScanningGroup

        Group that the given group belongs to as one of its elements.

        The default value is \c null.
    */
    property var parentScanningGroup: null

    /*!
        \qmlproperty PisakScanningStrategy PisakScanningGroup::strategy

        Strategy that manages the whole scanning cycle within the group.

        The default value is \c PisakScanningStrategyBasic.
    */
    property PisakScanningStrategy strategy: PisakScanningStrategyBasic { group: main }

    /*!
        \qmlproperty bool PisakScanningGroup::isScannable

        Indicates whether the group can be scanned. This property is read-only.

        The default value is \c true.
    */
    readonly property bool isScannable: true

    readonly property bool running: strategy.running

    readonly property string __styleState: __feedbackAnimationTimer.running ?
                                           __feedbackAnimationTimer.feedbackValue : state

    PisakSoundEffect {
        id: __sound
        source: soundName ? pisak.resources.getSoundPath(soundName) : ""
    }

    Timer {
        id: __feedbackTimeout
        running: state === "active"
        interval: activeFeedbackDuration
        repeat: false
        onTriggered: __afterSelect()
        triggeredOnStart: false
    }

    Timer {
        id: __feedbackAnimationTimer
        running: __feedbackTimeout.running
        repeat: true
        interval: activeFeedbackBlinkInterval / 2
        onTriggered: { feedbackValue = (feedbackValue === "active" ? "normal" : "active") }
        property string feedbackValue: "normal"
    }

    onElementsChanged: {
        if (elements !== undefined) {
            var newElements = new Array(0)
            for(var i = 0; i < elements.length; i++) {
                var el = elements[i]
                if (el !== undefined && el.isScannable) {
                    newElements.push(el)
                    el.parentScanningGroup = main
                }
            }
            validElements = newElements
        }
    }

    /*!
        \qmlmethod void PisakScanningSound::playSound()

        Plays sound that has been assigned to the group.
    */
    function playSound() {
        __sound.play()
    }

    function startScanning() {
        strategy.startCycle()
    }

    function stopScanning() {
        strategy.stopCycle()
    }

    function onInputEvent() {
        if (running) {
            var currentElement = strategy.getCurrentElement()
            if (currentElement !== null && currentElement !== undefined) {
                stopScanning()
                activeGroupChanged(currentElement)
                currentElement.select()
            }
        } else { startScanning() }
    }

    function select() {
        state = "active"
        __doSelect()
    }

    function unwind(levels) {
        if (parentScanningGroup !== null) {
            if (levels > 1) {
                parentScanningGroup.unwind(levels-1)
            } else {
                activeGroupChanged(parentScanningGroup)
                parentScanningGroup.onSubgroupUnwind()
            }
        }
    }

    function onSubgroupUnwind() {
        startScanning()
    }

    function __afterSelect() { startScanning() }

    function __doSelect() {}
}
