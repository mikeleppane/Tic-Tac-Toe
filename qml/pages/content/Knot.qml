import QtQuick 2.0

Item {
    property alias knotCanvas: canvas

    Canvas {
        id: canvas
        smooth: true
        width: 75
        height: 75
        onPaint: {
            var cxt = canvas.getContext('2d')
            var x = canvas.width / 2;
            var y = canvas.height / 2;
            var radius = 30;
            var startAngle = 0;
            var endAngle = 2 * Math.PI;
            var counterClockwise = false;

            cxt.beginPath();
            cxt.arc(x, y, radius, startAngle, endAngle, counterClockwise);
            cxt.lineWidth = 15;
            cxt.strokeStyle = '#3399CC';
            cxt.stroke();
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

