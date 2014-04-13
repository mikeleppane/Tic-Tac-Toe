/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0
import "content"
import "../logic.js" as Logic


Page {
    id: page

    property string player;
    property string player1Name: "Player 1"
    property string player2Name: "Player 2"
    property int player1Scores: 0
    property int player2Scores: 0
    property alias model: repeater.model
    signal clicked(int square)


    Timer {
        id: gameOverTimer
        interval: 5000
        running: false
        repeat: false
        onTriggered: {
            Logic.cleanUpGame();
            Logic.isGameRunning = true;
        }
    }

    SilicaFlickable {
        anchors.fill: parent;

        ScoreBoard {
            id: scoreBoard
            anchors {
                bottom: gameGrid.top
                bottomMargin: Theme.paddingLarge * 4
                horizontalCenter: parent.horizontalCenter
            }
            width: parent.width
        }

        Grid {
            id: gameGrid
            anchors.centerIn: parent
            rows: 3;
            columns: 3;
            spacing: 5

            Repeater {
                id: repeater

                model: new Array(9);

                Rectangle {
                    id: rect
                    width: 100; height:100
                    border.width: 2
                    border.color: "#CC6600"
                    radius: 5
                    color: "#336666";
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            if (Logic.gameObjects.length < 10 && !Logic.isIndexOccupied(index) && Logic
                                .isGameRunning) {
                                if (player === "knot") {
                                    Logic.gameObjects.push(Logic.createKnotObject(page));
                                    if (Logic.gameObjects[Logic.gameObjects.length - 1] !== null) {
                                        Logic.gameObjects[Logic.gameObjects.length - 1].knotCanvas.x =
                                            gameGrid.x + 12.5 + (index % 3) * rect.width + (index % 3) *
                                            5
                                        Logic.gameObjects[Logic.gameObjects.length - 1].knotCanvas.y =
                                            gameGrid.y + 12.5 + Math.floor(index / 3) * rect.width +
                                            Math.floor(index / 3) * 5
                                        Logic.updateMatrix(index, player)
                                        player = "cross"
                                    }

                                } else if (player === "cross") {
                                    Logic.gameObjects.push(Logic.createCrossObject(page));
                                    if (Logic.gameObjects[Logic.gameObjects.length - 1] !== null) {
                                        Logic.gameObjects[Logic.gameObjects.length - 1].crossCanvas.x =
                                            gameGrid.x + 12.5 + (index % 3) *
                                            rect.width + (index % 3) * 5
                                        Logic.gameObjects[Logic.gameObjects.length - 1].crossCanvas.y =
                                            gameGrid.y + 12.5 + Math.floor(index / 3) * rect.width +
                                            Math.floor(index / 3) * 5
                                        Logic.updateMatrix(index, player)
                                        player = "knot"
                                    }
                                }
                            }

                        }
                    }
                }
            }
        }
        Row {
            id: scorerow1
            anchors {
                top: gameGrid.bottom
                topMargin: Theme.paddingLarge
                left: parent.left
                leftMargin: Theme.paddingLarge
            }
            spacing: 5
            Knot {
                id: knot
                anchors.margins: 0
                width: 75
                height: 75
                scale: 0.25
            }
            Label {
                id: player1score
                transform: Translate {x: -Theme.paddingMedium}
                anchors.verticalCenter: knot.verticalCenter
                text: player1Name + ": " + player1Scores
                color: Theme.primaryColor
                font.pixelSize: Theme.fontSizeMedium
            }
        }
        Row {
            id: scorerow2
            anchors {
                top: gameGrid.bottom
                topMargin: Theme.paddingLarge
                left: scorerow1.right
                leftMargin: Theme.paddingLarge * 1.5
            }
            spacing: 5
            Cross {
                id: cross
                anchors.margins: 0
                width: 75
                height: 75
                scale: 0.25
            }
            Label {
                id: player2score
                anchors.verticalCenter: cross.verticalCenter
                transform: Translate {x: -Theme.paddingMedium}
                text: player2Name + ": " + player2Scores
                color: Theme.primaryColor
                font.pixelSize: Theme.fontSizeMedium
            }
        }

        Row {
            anchors {
                top: scorerow1.bottom
                topMargin: Theme.paddingLarge * 2
                horizontalCenter: parent.horizontalCenter
            }
            spacing: Theme.paddingLarge * 1.5
            Button {
               text: "Settings"
               onClicked: pageStack.push(Qt.resolvedUrl("content/Settings.qml"), {"container": page})

            }
            Button {
               text: "Reset Game"
               onClicked: Logic.startNewGame();
            }
        }
    }

    onStatusChanged: {
        if (status === PageStatus.Activating && !Logic.isGameRunning) {
            player = "knot"
            scoreBoard.winnerLabel = "Start playing!";
            scoreBoard.active = true;
            Logic.startNewGame();
        }
    }

}


