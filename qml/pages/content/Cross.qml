import QtQuick 2.0

Item {
    property alias crossCanvas: canvas

    Canvas {
        id: canvas
        smooth: true
        width: 75
        height: 75
        onPaint: {
            var cxt = canvas.getContext('2d')
            cxt.beginPath();
            cxt.moveTo(5, 5);
            cxt.lineTo(canvas.width - 5, canvas.height - 5);
            cxt.lineWidth = 15
            cxt.strokeStyle = '#FFFF66';
            cxt.stroke();
            var cxt2 = canvas.getContext('2d')
            cxt2.beginPath();
            cxt2.moveTo(canvas.width - 5, 5);
            cxt2.lineTo(5, canvas.height - 5);
            cxt2.lineWidth = 15
            cxt2.strokeStyle = '#FFFF66';
            cxt2.stroke();
        }

        Behavior on x {
            NumberAnimation {
                id: bouncebehavior
                easing {
                    type: Easing.OutElastic
                    amplitude: 0.5
                    period: 15
                }
            }
        }

        Behavior on y {
            animation: bouncebehavior
        }

        Behavior on opacity {
            NumberAnimation {from: 1; to: 0.2; duration: 2000;}
        }
    }
}
