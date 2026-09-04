import Quickshell
import Quickshell.Io
import QtQuick
import "../theme" as Theme

Item {
    id: root

    property bool micActive: false
    property bool camActive: false

    visible: micActive || camActive
    implicitWidth: visible ? row.implicitWidth : 0
    implicitHeight: row.implicitHeight

    Behavior on implicitWidth {
        NumberAnimation { duration: 150; easing.type: Easing.OutCubic }
    }

    Timer {
        interval: 1500
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            micProc.running = true
            camProc.running = true
        }
    }

    Process {
        id: micProc
        command: ["sh", "-c", "pactl list source-outputs short 2>/dev/null"]
        stdout: StdioCollector {
            onStreamFinished: root.micActive = text.trim().length > 0
        }
    }

    Process {
        id: camProc
        command: ["sh", "-c", "fuser /dev/video0 /dev/video1 2>/dev/null"]
        stdout: StdioCollector {
            onStreamFinished: root.camActive = text.trim().length > 0
        }
    }

    Row {
        id: row
        spacing: 6
        height: 8

        Rectangle {
            visible: root.micActive
            width: 8
            height: 8
            radius: 4
            color: Theme.Colors.color3
            anchors.verticalCenter: parent.verticalCenter
        }

        Rectangle {
            visible: root.camActive
            width: 8
            height: 8
            radius: 4
            color: Theme.Colors.color5
            anchors.verticalCenter: parent.verticalCenter
        }
    }
}