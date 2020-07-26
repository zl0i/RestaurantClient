import QtQuick 2.9
import QtGraphicalEffects 1.0

Rectangle {
    id: _updateItem

    readonly property double angle: percent >= 1 ? 1 : percent
    property bool preUpdate: false
    property bool updateRunnig: false
    property double speed: 1
    property bool enabledUpdate: true

    property int parentHeight: parent.height
    property int parentOvershoot
    property bool pressed
    property double percent: parentOvershoot/(parentHeight/6)

    property color backgroundColor: "#FFFFFF"
    property color contentColor: "#4682B4"
    //property var contentColorList: ["#4285F4", "#34A853", "#FBBC05", "#EA4335"]

    signal updateStart()
    signal updateFinish()
    z:5000
    visible: enabledUpdate
    anchors.horizontalCenter: parent.horizontalCenter
    y: {
        if(parentOvershoot === 0) return -5000
        return  parentOvershoot-height > parentHeight/6 ? parentHeight/6 : parentOvershoot-height-2
    }

    onPressedChanged: {
        if(!enabledUpdate) return
        if(pressed === false && parentOvershoot > parentHeight/10) {
            startUpdate()
        }
    }

    function startUpdate() {
        updateRunnig = true
        updateStart()
        y = parentHeight/6
       _preUpdateAnimation.start()
    }

    function stopUpdate() {
        if(updateRunnig) _stopAnimantion.start()
    }

    onUpdateRunnigChanged: _canvas.requestPaint()
    onAngleChanged: _canvas.requestPaint()


   NumberAnimation {
        id: _preUpdateAnimation
        target: _updateItem
        property: "y"
        from: parentHeight/6
        to: parentHeight/10
        duration: 150
        onStopped: {
           _updateItem.y = parentHeight/10
        }
    }

    NumberAnimation {
         id: _stopAnimantion
         target: _updateItem
         property: "scale"
         from: 1
         to: 0
         duration: 100
         onStopped: {
              updateFinish()
              updateRunnig = false
              _updateItem.scale = 1
              _updateItem.y = Qt.binding(function () {
                  if(parentOvershoot === 0) return -5000
                  return parentOvershoot-height > parentHeight/6 ? parentHeight/6 : parentOvershoot-height-2
              })
         }
    }

    width: 38; height: width
    radius: width/2
    color: backgroundColor
    layer.enabled: true
    layer.effect: DropShadow {
        color: "#80000000"
        samples: 15
        radius: 5
    }
    Canvas {
        id: _canvas
        anchors.fill: parent

        property var startAng: 0
        property var stopAng: 20

        antialiasing: true
        smooth: true
        onStopAngChanged: requestPaint()
        onStartAngChanged: requestPaint()

        opacity: _updateItem.updateRunnig ? 1 : _updateItem.angle
        rotation: _updateItem.updateRunnig ? 0 : _updateItem.angle*180


        RotationAnimation {
            target: _canvas
            from: 0; to: 360
            running: _updateItem.updateRunnig
            loops: Animation.Infinite
            duration: 2000 * _updateItem.speed
        }
        SequentialAnimation {
            property int count: 0
            running: _updateItem.updateRunnig
            loops: Animation.Infinite
            ParallelAnimation {
                NumberAnimation {
                    target: _canvas
                    property: "stopAng"
                    from: 40; to: 360
                    duration: 1000 * _updateItem.speed                    
                }
                NumberAnimation {
                    target: _canvas
                    property: "startAng"
                    from: 0; to: 40
                    duration: 1000 * _updateItem.speed
                    easing.type: Easing.OutCubic

                }

            }
            ParallelAnimation {
                NumberAnimation {
                    target: _canvas
                    property: "startAng"
                    from: 40; to: 360
                    duration: 1000 * _updateItem.speed
                    easing.type: Easing.OutCubic
                }
                NumberAnimation {
                    target: _canvas
                    property: "stopAng"
                    from: 0; to: 40
                    duration: 1000 * _updateItem.speed
                    easing.type: Easing.OutCubic
                }
            }
        }

        onPaint: {
            var ctx = getContext("2d")
            ctx.reset()
            var R = 9
            var centerX = width/2
            var centerY = height/2

            if(parent.updateRunnig === false) {
                var angRad =  _updateItem.angle*5.4
                var scl =  _updateItem.angle+0.2 >= 1 ? 1 :  _updateItem.angle+0.2
                var a = R * Math.cos(angRad) + centerX
                var b = R * Math.sin(angRad) + centerY
                //дуга
                ctx.lineWidth = 3
                ctx.strokeStyle = _updateItem.contentColor
                ctx.fillStyle = _updateItem.contentColor
                ctx.arc(centerX, centerY, R, 0, angRad)
                ctx.stroke()
                //треугольник
                ctx.translate(a, b);
                ctx.rotate(Math.PI + angRad)
                ctx.scale(scl, scl)
                ctx.lineWidth = 1
                ctx.beginPath()
                ctx.moveTo(0,0)
                ctx.moveTo(-4,0)
                ctx.lineTo(0,-4)
                ctx.lineTo(4,0)
                ctx.closePath()
                ctx.fill()
                ctx.stroke()
            }
            else {
                var start =  Math.PI * _canvas.startAng / 180
                var stop =   Math.PI * _canvas.stopAng / 180

                ctx.lineWidth = 3
                ctx.strokeStyle = _updateItem.contentColor
                ctx.fillStyle = _updateItem.contentColor
                ctx.arc(centerX, centerY, R, start, stop)
                ctx.stroke()
            }
        }
    }
}
