import Quickshell
import Quickshell.Wayland
import "./widgets" as Widgets

PanelWindow {
    id: root

    anchors {
        top: true
        left: true
        right: true
    }

    color: "transparent"
    margins.top: 8
    implicitHeight: Math.max(
        leftPill.implicitHeight,
        centerPill.implicitHeight,
        rightPill.implicitHeight
    ) + 8

    WlrLayershell.keyboardFocus: clockContainer && clockContainer.currentIndex === 3
        ? WlrKeyboardFocus.Exclusive
        : WlrKeyboardFocus.None

    Widgets.PillWidget {
        id: leftPill
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 14

        Widgets.Workspaces {}
    }

    Widgets.PillWidget {
        id: centerPill
        anchors.centerIn: parent

        Widgets.ClockContainer {
            id: clockContainer
        }
    }

    Widgets.PillWidget {
        id: rightPill
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.rightMargin: 14

        Widgets.System {}
        Widgets.MicCamIndicator {}
        Widgets.SystemTray {}
    }
}