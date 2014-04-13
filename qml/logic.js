// define needed game variables
var isGameRunning = false;
var winner;
var gameObjects = [];
var winningLineObj;
var gameMatrix;
var startLineX;
var startLineY;
var endLineX;
var endLineY;
var combinations = [[0, 1, 2], [3, 4, 5], [6, 7, 8],
                    [0, 3, 6], [1, 4, 7], [2, 5, 8],
                    [0, 4, 8], [2, 4, 6]];

function initializeGameMatrix() {
    gameMatrix = [];
    var i = 0;
    for (; i < 3; i++) {
        gameMatrix[i] = [];
        for (var j = 0; j < 3; ++j) {
            gameMatrix[i][j] = undefined;
        }
    }
}

function startNewGame() {
    isGameRunning = true;
    initializeGameMatrix();
    cleanUpGame();
    player1Scores = 0;
    player2Scores = 0;
}

function createKnotObject(parent) {
    var component = Qt.createComponent(Qt.resolvedUrl("pages/content/Knot.qml"));
    if (component.status === Component.Ready) {
        var object = component.createObject(parent);
        if (object === null) {
            console.log("error creating knot object...");
            console.log(component.errorString());
            return null;
        }
        return object;
    } else if (component.status === Component.Error) {
        console.log("error loading knot component");
        console.log(component.errorString());
        return null;
    }
}

function createCrossObject(parent) {
    var component = Qt.createComponent(Qt.resolvedUrl("pages/content/Cross.qml"));
    if (component.status === Component.Ready) {
        var object = component.createObject(parent);
        if (object === null) {
            console.log("error while creating cross object...");
            console.log(component.errorString());
            return null;
        }
        return object;
    } else if (component.status === Component.Error) {
        console.log("error while loading cross component");
        console.log(component.errorString());
        return null;
    }
}


function cleanUpGame() {
    initializeGameMatrix();
    var i = 0,
        count = gameObjects.length;
    for (; i < count; ++i)
        gameObjects[i].destroy();
    gameObjects = [];
    winner = undefined;
    if (!(typeof winningLineObj === 'undefined'))
        winningLineObj.destroy();
        winningLineObj = undefined;
}


function updateMatrix(index, player) {
    if (typeof gameMatrix[Math.floor(index / 3)][index % 3] === 'undefined')
        gameMatrix[Math.floor(index / 3)][index % 3] = player;
    checkGameState();
}

function createWinningLine(parent) {
    var component = Qt.createComponent(Qt.resolvedUrl("pages/content/Line.qml"));
    if (component.status === Component.Ready) {
        var object = component.createObject(parent, {
            "startLineX": startLineX,
            "startLineY": startLineY,
            "endLineX": endLineX,
            "endLineY": endLineY
        });
        var i = 0,
            count = gameObjects.length;
        for (; i < count; ++i)
            gameObjects[i].opacity = 0.2;
        return object;
    } else if (component.status === Component.Error) {
        console.log(component.errorString());
        return;
    }
}

function checkGameState() {
    // check whether game board has a winner of if it's a tie
    var i = 0;
    var gamePlayers = [];
    for (; i < 3; ++i) {
        for (var j = 0; j < 3; ++j) {
            gamePlayers.push(gameMatrix[i][j]);
        }
    }
    var k;
    for (k in combinations) {
        if ([gamePlayers[combinations[k][0]], gamePlayers[combinations[k][1]],
            gamePlayers[combinations[k][2]]].every(function checkEquality(
            element, index, array) {
            return (element === "knot");
        })) {
            isGameRunning = false;
            winner = "knot";
            var index1 = combinations[k][0];
            var index2 = combinations[k][2];
            startLineX = gameGrid.x + 50 + (index1 % 3) * 100 +
                (index1 % 3) * 5;
            startLineY = gameGrid.y + 50 +
                Math.floor(index1 / 3) * 100 + Math.floor(index1 / 3) * 5;
            if (index1 === 2 && index2 === 6) {
                endLineX = startLineX - Math.floor(index2 / 3) * 100 -
                    Math.floor(index2 / 3) * 5;
            } else {
                if ((index1 % 3) === (index2 % 3)) {
                    endLineX = startLineX;
                } else {
                    endLineX = startLineX + (index2 % 3) * 100 +
                        (index2 % 3) * 5;
                }
            }
            if (Math.floor(index1 / 3) === Math.floor(index2 / 3)) {
                endLineY = startLineY;
            } else {
                endLineY = startLineY +
                    Math.floor(index2 / 3) * 100 + Math.floor(index2 / 3) * 5;
            }
            winningLineObj = createWinningLine(page);
            scoreBoard.winnerLabel = player1Name + " wins!";
            scoreBoard.active = true;
            gameOverTimer.start();
            player1Scores += 1;
            return;
        } else if ([gamePlayers[combinations[k][0]], gamePlayers[combinations[k]
                [1]],
                    gamePlayers[combinations[k][2]]].every(function checkEquality(
            element, index, array) {
            return (element === "cross");
        })) {
            isGameRunning = false;
            winner = "cross";
            var index1_ = combinations[k][0];
            var index2_ = combinations[k][2];
            startLineX = gameGrid.x + 50 + (index1_ % 3) * 100 +
                (index1_ % 3) * 5;
            startLineY = gameGrid.y + 50 +
                Math.floor(index1_ / 3) * 100 + Math.floor(index1_ / 3) * 5;

            if (index1_ === 2 && index2_ === 6) {
                endLineX = startLineX - Math.floor(index2_ / 3) * 100 -
                    Math.floor(index2_ / 3) * 5;
            } else {
                if ((index1_ % 3) === (index2_ % 3)) {
                    endLineX = startLineX;
                } else {
                    endLineX = startLineX + (index2_ % 3) * 100 +
                        (index2_ % 3) * 5;
                }
            }
            if (Math.floor(index1_ / 3) === Math.floor(index2_ / 3)) {
                endLineY = startLineY;
            } else {
                endLineY = startLineY +
                    Math.floor(index2_ / 3) * 100 + Math.floor(index2_ / 3) * 5;
            }
            winningLineObj = createWinningLine(page);
            scoreBoard.winnerLabel = player2Name + " wins!";
            scoreBoard.active = true;
            gameOverTimer.start();
            player2Scores += 1;
            return;
        }
    }
    if (gamePlayers.every(function checkTie(element, index, array) {
            return element === "knot" || element === "cross";
        }) &&
        typeof winner === 'undefined') {
        scoreBoard.winnerLabel = "It's a tie!"
        scoreBoard.active = true;
        gameOverTimer.start();
    }

}

function isIndexOccupied(index) {
    // check that clicked square does not already
    // include an object
    if (typeof gameMatrix[Math.floor(index / 3)][index % 3] === 'undefined') {
        return false;
    } else {
        return true;
    }
}
