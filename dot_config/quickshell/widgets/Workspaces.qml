import Quickshell.Hyprland
import QtQuick
import "../theme" as Theme

Repeater {
    model: 9

    delegate: Rectangle {
        id: wsDelegate
        readonly property int workspaceId: index + 1
        readonly property bool isActive: Hyprland.focusedWorkspace !== null && Hyprland.focusedWorkspace.id === workspaceId

        implicitWidth: 20
        implicitHeight: 20
        radius: implicitHeight / 2

        color: isActive ? Theme.Colors.color2 : Theme.Colors.color8

        Behavior on color {
            ColorAnimation { duration: 150 }
        }

        Rectangle {
            anchors.centerIn: parent
            implicitWidth: wsDelegate.isActive ? 10 : 6
            implicitHeight: wsDelegate.isActive ? 10 : 6
            radius: implicitHeight / 2

            color: wsDelegate.isActive ? Theme.Colors.color0 : Theme.Colors.foreground

            Behavior on implicitWidth { NumberAnimation { duration: 150 } }
            Behavior on implicitHeight { NumberAnimation { duration: 150 } }
        }

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor

            onClicked: {
                Hyprland.dispatch(`hl.dsp.focus({ workspace = ${wsDelegate.workspaceId} })`)
            }
        }
    }
}
