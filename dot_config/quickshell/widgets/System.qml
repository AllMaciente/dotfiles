import Quickshell
import Quickshell.Io
import QtQuick
import "../theme" as Theme

Item {
    id: root

    property real cpuUsage: 0
    property real ramUsage: 0

    property var prevIdle: 0
    property var prevTotal: 0

    implicitWidth: row.implicitWidth
    implicitHeight: row.implicitHeight

    Timer {
        interval: 2000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            cpuProc.running = true
            ramProc.running = true
        }
    }

    Process {
        id: cpuProc
        command: ["sh", "-c", "head -n1 /proc/stat"]
        stdout: StdioCollector {
            onStreamFinished: {
                const parts = text.trim().split(/\s+/).slice(1).map(Number)
                const idle = parts[3] + parts[4]
                const total = parts.reduce((a, b) => a + b, 0)

                const deltaIdle = idle - root.prevIdle
                const deltaTotal = total - root.prevTotal

                if (root.prevTotal > 0 && deltaTotal > 0) {
                    root.cpuUsage = Math.round((1 - deltaIdle / deltaTotal) * 100)
                }

                root.prevIdle = idle
                root.prevTotal = total
            }
        }
    }

    Process {
        id: ramProc
        command: ["sh", "-c", "grep -E 'MemTotal|MemAvailable' /proc/meminfo"]
        stdout: StdioCollector {
            onStreamFinished: {
                const lines = text.trim().split("\n")
                const total = parseInt(lines[0].match(/\d+/)[0])
                const available = parseInt(lines[1].match(/\d+/)[0])
                root.ramUsage = Math.round((1 - available / total) * 100)
            }
        }
    }
    Row {
        id: row
        spacing: 10

        Row {
            spacing: 4
            Theme.AppText {
                text: "\uf4bc"  // nf-fa-microchip
                color: Theme.Colors.color3
            }
            Theme.AppText {
                text: root.cpuUsage + "%"
                color: Theme.Colors.color3
            }
        }

        Row {
            spacing: 4
            Theme.AppText {
                text: "\uefc5"  // nf-fa-memory (RAM)
                color: Theme.Colors.color5
            }
            Theme.AppText {
                text: root.ramUsage + "%"
                color: Theme.Colors.color5
            }
        }
    }
}