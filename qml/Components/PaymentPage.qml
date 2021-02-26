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
        Image {
            x: 20
            anchors.verticalCenter: parent.verticalCenter
            width: 40
            height: 40
            source: "qrc:icons/arrowBack-black.svg"
            antialiasing: true
            MouseArea {
                anchors.fill: parent
                onClicked: _page.back()
            }
        }
    }

    WebView {
        id: _webView
        y: 60
        width: parent.width
        height: parent.height - 60

        onUrlChanged: {
            if(url == 'https://yandex.ru/') {
                _page.visible = false
                _webView.stop()
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

