import QtQuick 2.5
import "../media"

/*!
    \qmltype PisakScanningGroup
    \brief Single scanning group that can consist of multiple elements

    Groups together elements that are somehow related to each other or have
    something in common (but not necessarily are placed next to each other in the graphical layout)
    and should be scanned within the same scanning cycle.
*/
Item {
    id: main

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

    property string __state: parentScanningGroup.state

    on__StateChanged: { if (__state !== "active") { state = __state } }

    property string soundName: ""

    property var elements: []
    property var parentScanningGroup: ({})

    property PisakScanningStrategy strategy: PisakScanningStrategyBasic { group: main }

    readonly property bool isScannable: true

    readonly property bool running: strategy.running

    PisakSoundEffect {
        id: __sound
        source: pisak.resources.getSoundPath(soundName)
    }

    onElementsChanged: {
        for(var i = 0; i < elements.length; i++) {
            if (!elements[i].isScannable) {
                // elements.splice(i, 1)
            } else { elements[i].parentScanningGroup = main }
        }
    }

    function playSound() {
        __sound.play()
    }

    function startScanning() {
        state = "active"
        strategy.startCycle()
    }

    function stopScanning() {
        strategy.stopCycle()
    }

    function onInputEvent() {
        var currentElement = strategy.getCurrentElement()
        stopScanning()
        activeGroupChanged(currentElement)
        currentElement.select()
    }

    function select() {
        startScanning()
    }

    function unwind() {
        if (parentScanningGroup) {
            activeGroupChanged(parentScanningGroup)
            parentScanningGroup.onSubgroupUnwind()
        }
    }

    function onSubgroupUnwind() {
        startScanning()
    }
}
