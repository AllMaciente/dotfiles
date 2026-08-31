import QtQuick

Text {
    font.family: "JetBrainsMono Nerd Font"
    font.pixelSize: 14
    color: Colors.foreground

    Behavior on opacity {
        NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
    }

    Behavior on x {
        NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
    }

    Behavior on y {
        NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
    }
}