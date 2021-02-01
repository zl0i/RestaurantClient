import QtQuick 2.12

Canvas {
    id: _canvas
    anchors.centerIn: parent
    width: 50
    height: 50

    property bool running: false
    property var radius: Math.min(width, height)/2
    property color externalColor: "#3CB371"
    property color internalColor: "#1A1A1A"

    property real angle: 0

    onAngleChanged: requestPaint()

    NumberAnimation {
        target: _canvas
        property: "angle"
        from: 0; to: 360
        running: _canvas.running
        loops: Animation.Infinite
        duration: 1500
    }

    onPaint: {
        var ctx = getContext("2d")
        ctx.reset()
        var centerX = width/2
        var centerY = height/2
        ctx.lineWidth = 3

        var angleK = angle*Math.PI/180

        ctx.strokeStyle = "#3CB371"
        ctx.beginPath()
        ctx.arc(centerX, centerY, _canvas.radius-ctx.lineWidth, 0 + angleK, Math.PI + angleK);
        ctx.stroke()

        ctx.translate(centerX,centerY )
        ctx.rotate(75*Math.PI/180)

        ctx.strokeStyle = "#1A1A1A"
        ctx.beginPath()
        ctx.arc(0, 0, _canvas.radius-ctx.lineWidth-10, 0 + angleK*2, Math.PI + angleK*2);
        ctx.stroke()
    }
}
