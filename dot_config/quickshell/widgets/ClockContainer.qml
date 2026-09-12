import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import "../service"
Item {
    id: root
    property bool clockLocked: false
    property bool clockExpanded: hoverHandler.hovered || clockLocked

    property int ipcIndex: 0
    property bool volumeActive: false
    
    property int currentIndex: {
        if (volumeActive) return 2
        if (ipcIndex !== 0) return ipcIndex
        return clockExpanded ? 1 : 0
    }
    property var views: [clockView, bigClockView, volumeView, powerView]
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

  Connections {
        target: NotificationServer
        function onNewNotification(notification) {
            notifView.notification = notification
            root.notifActive = true
            notifHideTimer.restart()
        }
    }

  StackLayout {
    id: stack
    anchors.fill: parent
    currentIndex: root.currentIndex

    ClockWidget {
        id: clockView
        Layout.fillWidth: false
        Layout.fillHeight: false
    }
    BigClock {
        id: bigClockView
        onBackgroundClicked: root.clockLocked = !root.clockLocked
        Layout.fillWidth: false
        Layout.fillHeight: false
    }
    VolumeWidget {
        id: volumeView
        onChanged: {
            root.volumeActive = true
            volumeHideTimer.restart()
        }
        Layout.fillWidth: false
        Layout.fillHeight: false
    }
    PowerWidget {
        id: powerView
        onCloseRequested: root.ipcIndex = 0
        Layout.fillWidth: false
        Layout.fillHeight: false
    } 
  }
    Timer {
        id: volumeHideTimer
        interval: 1000
        onTriggered: root.volumeActive = false
    }
}
