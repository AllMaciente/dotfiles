import Quickshell
import QtQuick
import QtQuick.Layouts

Item {
    id: root

    property bool locked: false
    property bool expanded: hoverHandler.hovered || locked

    implicitWidth: stack.currentIndex === 0 ? clockView.implicitWidth : bigClockView.implicitWidth
    implicitHeight: stack.currentIndex === 0 ? clockView.implicitHeight : bigClockView.implicitHeight

    Behavior on implicitWidth {
        NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
    }
    Behavior on implicitHeight {
        NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
    }

    HoverHandler {
        id: hoverHandler
    }

    StackLayout {
        id: stack
        anchors.fill: parent
        currentIndex: root.expanded ? 1 : 0

        ClockWidget {
            id: clockView
        }

        BigClock {
            id: bigClockView
            onBackgroundClicked: root.locked = !root.locked
        }
    }
}