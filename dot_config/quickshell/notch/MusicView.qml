import "../theme" as Theme
import QtQuick
import QtQuick.Layouts

Item {
    implicitWidth: 400
    implicitHeight: 120
    property real cornerRadius: 30 

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 30
        spacing: 12

        Rectangle {
            Layout.preferredWidth: 96
            Layout.preferredHeight: 96
            radius: 8
            color: "#333"
            // aqui entraria a capa do álbum
        }

        ColumnLayout {
            Layout.fillWidth: true
            Theme.AppText { text: "Nome da música"; color: "white"; font.bold: true }
            Theme.AppText { text: "Artista"; color: "#aaa" }
        }
    }
}