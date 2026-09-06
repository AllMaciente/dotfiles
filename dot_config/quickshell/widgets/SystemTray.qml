import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Io

RowLayout {
    id: root
    
    // Propriedades expostas para customizar
    property int iconSize: 16
    property int itemSpacing: 4
    
    spacing: itemSpacing
    
    // Estado interno
    property var trayItems: []

    Process {
        id: trayWatcher
        command: ["trayctl", "subscribe"]
        running: true

        stdout: SplitParser {
            onRead: data => {
                try {
                    let str = data.trim();
                    if (str !== "") {
                        root.trayItems = JSON.parse(str);
                    }
                } catch(e) {
                    console.log("Erro ao parsear JSON do trayd:", e);
                }
            }
        }
    }

    Process {
        id: menuLauncher
        running: false
    }

    Repeater {
        model: root.trayItems

        Rectangle {
            width: root.iconSize + 8
            height: root.iconSize + 8
            radius: 4
            color: hover.hovered ? "#33ffffff" : "transparent"

            HoverHandler { id: hover }

            Image {
                anchors.centerIn: parent
                width: root.iconSize
                height: root.iconSize
                source: "image://icon/" + modelData.icon_handle 
                sourceSize: Qt.size(root.iconSize, root.iconSize)
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    menuLauncher.command = [
                        "trayctl", 
                        "menu", 
                        "--app-id", modelData.app_id, 
                        "--dmenu-cmd", "rofi -dmenu"
                    ]
                    menuLauncher.running = true
                }
            }
        }
    }
}