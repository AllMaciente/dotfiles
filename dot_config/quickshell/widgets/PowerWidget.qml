import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import "../theme" as Theme

Item {
    id: root
    implicitWidth: row.implicitWidth + 16
    implicitHeight: 36

    signal closeRequested()

    property int selectedIndex: 0
    readonly property var actions: [
        { name: "lock",     icon: "󰌾", cmd: ["hyprlock"] },
        { name: "logout",   icon: "󰍃", cmd: ["loginctl", "terminate-user", "$USER"] },
        { name: "reboot",   icon: "󰜉", cmd: ["systemctl", "reboot"] },
        { name: "shutdown", icon: "󰐥", cmd: ["systemctl", "poweroff"] }
    ]

    focus: true

    onVisibleChanged: {
        if (visible) {
            Qt.callLater(() => {
                forceActiveFocus()
                selectedIndex = 0 // Opcional: reseta a seleção para o primeiro item
            })
        }
    }

    Keys.onLeftPressed:  selectedIndex = (selectedIndex - 1 + actions.length) % actions.length
    Keys.onRightPressed: selectedIndex = (selectedIndex + 1) % actions.length
    Keys.onReturnPressed: execute()
    Keys.onEnterPressed:  execute()

    function execute() {
        execProc.command = root.actions[root.selectedIndex].cmd
        execProc.running = true
        root.closeRequested()
    }

    Process {
        id: execProc
    }

    Rectangle {
        anchors.fill: parent
        radius: height / 2
        color: Theme.Colors.background

        RowLayout {
            id: row
            anchors.centerIn: parent
            spacing: 6

            Repeater {
                model: root.actions

                delegate: Rectangle {
                    width: 28
                    height: 28
                    radius: width / 2
                    color: index === root.selectedIndex ? Theme.Colors.accent : "transparent"

                    Behavior on color { ColorAnimation { duration: 120 } }

                    Text {
                        anchors.centerIn: parent
                        text: modelData.icon
                        font.family: "Symbols Nerd Font"
                        font.pixelSize: 14
                        color: index === root.selectedIndex ? Theme.Colors.background :  Theme.Colors.accent
                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: root.selectedIndex = index
                        onClicked: {
                            root.selectedIndex = index
                            root.execute()
                        }
                    }
                }
            }
        }
    }
}