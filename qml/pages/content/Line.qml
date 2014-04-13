import QtQuick 2.0
import Sailfish.Silica 1.0

Item {
    anchors.fill: parent
    property alias lineCanvas: canvas
    property int startLineX;
    property int startLineY;
    property int endLineX;
    property int endLineY;

    Canvas {
        id: canvas
        width: Screen.width
        height: Screen.height
        z: 1000
        smooth: true
        opacity: 0;

        onPaint: {
            var cxt = canvas.getContext('2d')
            cxt.beginPath();
            cxt.moveTo(startLineX, startLineY);
            cxt.lineTo(endLineX, endLineY);
            cxt.lineWidth = 5
            var grd = context.createLinearGradient(startLineX, startLineY,
                                                   endLineX, endLineY);
            grd.addColorStop(0, '#FF6666');
            grd.addColorStop(1, '#CC0000');
            cxt.strokeStyle = grd;
            cxt.stroke();
        }
        Behavior on opacity {
            NumberAnimation {duration: 1500;}
        }

        Component.onCompleted: {
            canvas.opacity = 1.0;
        }
    }
}
