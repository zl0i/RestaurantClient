import QtQuick 2.15
import QtQuick.Controls 2.15
import QtWebView 1.11

Item {
    id: _page
    width: parent.width
    height: parent.height

    signal back()
    signal error(var text)

    function open(html) {
        _page.visible = true
        _webView.loadHtml(html, "")
    }

    function close() {
        _page.visible = false
    }

    Rectangle {
        width: parent.width
        height: 60
        color: "#FFFFFF"
        Row {
            x: 20
            height: parent.height
            spacing: 20
            Image {
                anchors.verticalCenter: parent.verticalCenter
                width: 20; height: 20
                antialiasing: true
                smooth: true
                source: "qrc:icons/arrowBack-black.svg"
                MouseArea {
                    anchors.fill: parent
                    onClicked: _page.back()
                }
            }
            Label {
                anchors.verticalCenter: parent.verticalCenter
                font { pixelSize: 20; bold: true }
                text: qsTr("Оплата")
            }
        }
    }

    Timer {
        id: _closeTimer
        interval: 5000
        running: false
        repeat: false
        onTriggered: {
            _page.visible = false
        }
    }

    WebView {
        id: _webView
        y: 60
        width: parent.width
        height: parent.height - 60

        onUrlChanged: {
            if(url == core.host + "/azia/html/paymentSuccess.html") {
                _closeTimer.start()
            }
        }
        onLoadingChanged: {
            if(loadRequest.status === WebView.LoadFailedStatus) {
                console.log('error:', loadRequest.errorString)
                _page.error(loadRequest.errorString)
            }
        }
    }
}
