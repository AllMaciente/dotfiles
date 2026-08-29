import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import "../theme" as Theme

Item {
    id: root

    property real cornerRadius: implicitHeight / 2
    implicitWidth: Math.max(trayRow.implicitWidth + 40, 100)
    implicitHeight: 40

    RowLayout {
        id: trayRow
        anchors.centerIn: parent
        spacing: 8

        Theme.AppText {
            text: "Tray"
            color: Theme.Colors.foreground
            visible: SystemTray.items.count === 0
            Layout.alignment: Qt.AlignVCenter
        }

        Repeater {
            model: SystemTray.items

            delegate: Item {
                id: trayEntry
                required property SystemTrayItem modelData

                implicitWidth: 22
                implicitHeight: 22
                Layout.alignment: Qt.AlignVCenter

                IconImage {
                    anchors.fill: parent
                    source: trayEntry.modelData.icon
                    asynchronous: true
                }

                // Menu de Contexto Personalizado
                Menu {
                    id: customContextMenu

                    MenuItem {
                        text: "Configurações"
                        onTriggered: {
                            // Coloque o comando para abrir a sua janela de configurações aqui
                            configWindow.visible = true; 
                        }
                    }

                    MenuSeparator {}

                    MenuItem {
                        text: "Abrir Aplicativo"
                        onTriggered: trayEntry.modelData.activate()
                    }
                }

                QsMenuAnchor {
                    id: contextMenu
                    menu: trayEntry.modelData.menu
                    anchor.item: trayEntry
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton

                    onClicked: (mouse) => {
                        if (mouse.button === Qt.LeftButton) {
                            if (trayEntry.modelData.onlyMenu) {
                                customContextMenu.popup();
                            } else {
                                trayEntry.modelData.activate();
                            }
                        } else if (mouse.button === Qt.RightButton) {
                            // Se a aplicação nativa do tray já tiver menu, usa o nativo, senão abre o seu:
                            if (trayEntry.modelData.menu) {
                                contextMenu.open();
                            } else {
                                customContextMenu.popup();
                            }
                        } else if (mouse.button === Qt.MiddleButton) {
                            trayEntry.modelData.secondaryActivate();
                        }
                    }

                    onWheel: (wheel) => {
                        trayEntry.modelData.scroll(wheel.angleDelta.y, false);
                    }

                    ToolTip.visible: containsMouse && trayEntry.modelData.tooltipTitle.length > 0
                    ToolTip.text: trayEntry.modelData.tooltipTitle
                    ToolTip.delay: 400
                }
            }
        }
    }
}