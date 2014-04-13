import QtQuick 2.0
import Sailfish.Silica 1.0

Dialog {
    id: dialog
    width: Screen.width
    height: Screen.height
    property var container;

    SilicaFlickable {
        id: view
        anchors.fill: parent
        clip: true
        focus: true

        DialogHeader {
            id: dialogHeader
            anchors {
                topMargin: Theme.paddingMedium
                left: parent.left
            }

        }
        Column {
            anchors {
                top: dialogHeader.bottom
                topMargin: Theme.paddingMedium
            }
            width: dialog.width
            spacing: Theme.paddingLarge
            TextField {
                 id: player1name
                 focus: true
                 width: parent.width
                 font.pixelSize: Theme.fontSizeSmall
                 anchors.margins: Theme.paddingSmall
                 color: "steelblue"
                 placeholderText: qsTr("Set player 1 name...")
                 label: qsTr("Player 1 name")
                 validator: RegExpValidator { regExp: /^[0-9\_\#\-A-Za-z\s]+$/ }
                 errorHighlight: text ? !acceptableInput : false
                 inputMethodHints: Qt.ImhNoPredictiveText
            }
            TextField {
                 id: player2name
                 focus: true
                 width: parent.width
                 font.pixelSize: Theme.fontSizeSmall
                 anchors.margins: Theme.paddingSmall
                 color: "steelblue"
                 placeholderText: qsTr("Set player 2 name...")
                 label: qsTr("Player 2 name")
                 validator: RegExpValidator { regExp: /^[0-9\_\#\-A-Za-z\s]+$/ }
                 errorHighlight: text ? !acceptableInput : false
                 inputMethodHints: Qt.ImhNoPredictiveText
            }
        }
    }
    onOpened: {
        if (typeof container.player1Name !== 'undefined') {
            player1name.text = container.player1Name;
        }
        if (typeof container.player2Name !== 'undefined') {
            player2name.text = container.player2Name;
        }

    }

    onDone: {
        if (player1name.text !== "" && player2name.text !== "") {
            container.player1Name = player1name.text;
            container.player2Name = player2name.text;
        }
    }
}
