import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import "../theme" as Theme

Item {
    id: root
    default property alias content: contentLayout.data

    implicitWidth: bgRect.implicitWidth
    implicitHeight: bgRect.implicitHeight

    Rectangle {
        id: bgRect
        color: Theme.Colors.background
        radius: implicitHeight / 2

        implicitWidth: contentLayout.implicitWidth + 30
        implicitHeight: contentLayout.implicitHeight + 10

        RowLayout {
            id: contentLayout
            anchors.centerIn: parent
            spacing: 8
        }
    }

    MultiEffect {
        source: bgRect
        anchors.fill: bgRect
        shadowEnabled: true
        shadowColor: "#80000000"
        shadowBlur: 0.6
        shadowVerticalOffset: 3
    }
}
