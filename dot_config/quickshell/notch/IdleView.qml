import QtQuick
import QtQuick.Layouts
import QtCore
import Quickshell.Hyprland
import "../theme" as Theme
Item {
    implicitWidth: rowLayout.implicitWidth + 40
    implicitHeight: 40
    
Timer {
    id: clock
    property date currentDate: new Date()
    interval: 1000
    running: true
    repeat: true
    onTriggered: currentDate = new Date()
}
    RowLayout {
        id: rowLayout
        anchors.fill: parent
        anchors.leftMargin: 20
        anchors.rightMargin: 20
        spacing: 12

        Theme.AppText {
            text: Qt.formatDateTime(clock.currentDate,"hh:mm")
            color: Theme.Colors.foreground
            Layout.alignment: Qt.AlignVCenter
        }

        RowLayout {
            spacing: 4
            Layout.alignment: Qt.AlignVCenter

            Repeater {
                model: Hyprland.workspaces

                Rectangle {
                    id: wsButton
                    readonly property bool active: modelData.active

                    height: 24
                    implicitWidth: active ? (label.implicitWidth + 30) : height
                    radius: height / 2

                    color: active ? Theme.Colors.color2 : Theme.Colors.color8

                    Layout.topMargin: 2
                    Layout.bottomMargin: 2
                    Layout.leftMargin: 3
                    Layout.rightMargin: 3

                    Behavior on implicitWidth {
                        NumberAnimation { duration: 300; easing.type: Easing.InOutQuad }
                    }
                    Behavior on color {
                        ColorAnimation { duration: 300; easing.type: Easing.InOutQuad }
                    }

                    Theme.AppText {
                        id: label
                        anchors.centerIn: parent
                        text: modelData.id
                        color: wsButton.active ? Theme.Colors.color8 : Theme.Colors.foreground

                        Behavior on opacity {
                            NumberAnimation { duration: 200 }
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: Hyprland.dispatch("workspace " + modelData.id)
                    }
                }
            }
        }
    }

}

