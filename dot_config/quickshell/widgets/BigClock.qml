import Quickshell
import QtQuick
import "../theme" as Theme

Item {
    id: root
    implicitWidth: textLabel.implicitWidth * 3
    implicitHeight: textLabel.implicitHeight * 2

    signal backgroundClicked()

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }

    TapHandler {
        onTapped: root.backgroundClicked()
    }

    Theme.AppText {
        id: textLabel
        anchors.centerIn: parent
        text: Qt.formatDateTime(clock.date, "hh:mm")
        font.pixelSize:28
        color: Theme.Colors.foreground
    }
}