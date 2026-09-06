import Quickshell
import Quickshell.Services.Pipewire
import QtQuick
import "../theme" as Theme

Item {
    id: root

    readonly property var sink: Pipewire.defaultAudioSink
    readonly property real volume: sink?.audio.volume ?? 0
    readonly property bool muted: sink?.audio.muted ?? false

    signal changed()

    PwObjectTracker {
        objects: [ Pipewire.defaultAudioSink ]
    }

    onVolumeChanged: root.changed()
    onMutedChanged: root.changed()

    implicitWidth: 160
    implicitHeight: column.implicitHeight + 16

    Column {
        id: column
        anchors.centerIn: parent
        spacing: 4
        width: parent.width - 24

        Theme.AppText {
            anchors.horizontalCenter: parent.horizontalCenter
            text: root.muted ? "Mudo" : Math.round(root.volume * 100) + "%"
            color: Theme.Colors.foreground
        }

        Rectangle {
            width: parent.width
            height: 6
            radius: 3
            color: Theme.Colors.color8

            Rectangle {
                width: parent.width * Math.min(root.volume, 1.0)
                height: parent.height
                radius: 3
                color: Theme.Colors.accent
            }
        }
    }
}