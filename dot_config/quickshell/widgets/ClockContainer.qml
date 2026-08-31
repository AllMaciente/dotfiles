import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

Item {
    id: root

    property bool clockLocked: false
    property bool clockExpanded: hoverHandler.hovered || clockLocked

 
    property int ipcIndex: 0

    property int currentIndex: ipcIndex !== 0 ? ipcIndex : (clockExpanded ? 1 : 0)

    property var views: [clockView, bigClockView]

    implicitWidth: views[currentIndex] ? views[currentIndex].implicitWidth : 0
    implicitHeight: views[currentIndex] ? views[currentIndex].implicitHeight : 0

    Behavior on implicitWidth {
        NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
    }
    Behavior on implicitHeight {
        NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
    }

    HoverHandler {
        id: hoverHandler
    }

    IpcHandler {
        target: "center"

        function toggle(index: int): void {
            root.ipcIndex = (root.ipcIndex === index) ? 0 : index
        }
    }

    StackLayout {
        id: stack
        anchors.fill: parent
        currentIndex: root.currentIndex

        ClockWidget {
            id: clockView
        }

        BigClock {
            id: bigClockView
            onBackgroundClicked: root.clockLocked = !root.clockLocked
        }
    }
}