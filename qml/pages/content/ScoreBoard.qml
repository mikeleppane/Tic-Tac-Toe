import QtQuick 2.0
import Sailfish.Silica 1.0

Item {
    id: winnerboard
    property alias winnerLabel: winnerlabel.text
    property bool active: false
    visible: false

    Rectangle {
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width / 2
        height: Theme.itemSizeSmall
        color: "#CC9900"
        radius: 20
        border.color: "#CC6600"
        border.width: 2
        Text {
            id: winnerlabel
            width: parent.width*0.9
            anchors.centerIn: parent
            horizontalAlignment: TextEdit.AlignHCenter
            color: "black"
            font.pixelSize: Theme.fontSizeSmall
            font.bold: true
            wrapMode: Text.WordWrap
            elide: Text.ElideRight
        }
    }

    states: [
        State {
            when: winnerboard.active
            PropertyChanges {
                target: winnerboard; visible: true
            }
        },
        State {
            when: !winnerboard.active
            PropertyChanges {
                target: winnerboard; visible: false
            }
        }
    ]
    transitions: Transition {
            from: "*"
            to: "*"
            NumberAnimation { property: "visible"
                              easing.type: Easing.InOutQuad }
            }
    Timer {
        id: timer
        interval: 5000
        repeat: false
        running: active
        onTriggered: { active = false;
        }
    }
}
