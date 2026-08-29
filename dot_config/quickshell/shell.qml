import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import "./theme" as Theme
import "./notch"

ShellRoot {

    IpcHandler {
        target: "notch"
        function setPage(page: string): void {
            if (page === "idle") stack.currentIndex = 0
            else if (page === "music") stack.currentIndex = 1
            else if (page === "tray") stack.currentIndex = 2

        }
    }

    PanelWindow {
        id: notchWindow
        anchors.top: true
        margins.top: 8
        color: "transparent"

        property Item activePage: stack.children[stack.currentIndex]
        property real activeRadius: activePage && activePage.cornerRadius !== undefined
                                         ? activePage.cornerRadius
                                         : implicitHeight / 2

        implicitWidth: activePage ? activePage.implicitWidth : 180
        implicitHeight: activePage ? activePage.implicitHeight : 32

        Behavior on implicitWidth { NumberAnimation { duration: 250; easing.type: Easing.OutCubic } }
        Behavior on implicitHeight { NumberAnimation { duration: 250; easing.type: Easing.OutCubic } }

        Rectangle {
            id: notchBackground
            anchors.fill: parent
            radius: notchWindow.activeRadius
            color: Theme.Colors.background
            clip: true

            Behavior on radius {
                NumberAnimation { duration: 250; easing.type: Easing.OutCubic }
            }

            HoverHandler {
                id: notchHover
                onHoveredChanged: {
                    if (hovered) {
                        // só expande se estiver em idle
                        if (stack.currentIndex === 0)
                            stack.currentIndex = 2
                    } else {
                        // só volta pro idle se saiu da view expandida
                        if (stack.currentIndex === 2)
                            stack.currentIndex = 0
                    }
                }
            }

            StackLayout {
                id: stack
                anchors.fill: parent
                currentIndex: 0

                IdleView { }
                MusicView { }
                TrayView { }
            }
        }
    }
}