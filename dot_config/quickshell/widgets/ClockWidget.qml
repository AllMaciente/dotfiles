import Quickshell
import QtQuick
import "../theme" as Theme

Item {
    implicitWidth: textLabel.implicitWidth
    implicitHeight: textLabel.implicitHeight

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }

    Theme.AppText {
        id: textLabel
        anchors.centerIn: parent
        text: Qt.formatDateTime(clock.date, "hh:mm")
        color: Theme.Colors.foreground
    }
}
