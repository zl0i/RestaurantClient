pragma Singleton
import QtQuick 2.0

QtObject {

    property int timeout: 30000

    function ajaxPOST(url, body, success, fail) {
        var xhr = new XMLHttpRequest()
        xhr.timeout = timeout
        xhr.open("POST", url, true)        

        xhr.setRequestHeader('Content-Type', 'application/json')
        xhr.setRequestHeader('Content-Length', body.length)

        xhr.onload = function() {

            if(xhr.status >= 200 && xhr.status < 300) {
                success(xhr.responseText, xhr.status)
            } else {
               fail(xhr.status, xhr.responseText)
            }
        }

        xhr.onerror = function() {
            fail(xhr.status, xhr.statusText)
        }

        xhr.send(body)
    }

    function ajaxGET(url, data, success, fail) {
        var xhr = new XMLHttpRequest()
        xhr.timeout = timeout

        var fullUrl = url
        if(data !== "")
            fullUrl += '?' + data;
        xhr.open("GET", fullUrl, true)

        xhr.onload = function() {
            if(xhr.status >= 200 && xhr.status < 300) {
                success(xhr.responseText, xhr.status)
            } else {
               fail(xhr.status, xhr.responseText)
            }
        }

        xhr.onerror = function() {
            fail(xhr.status, xhr.statusText)
        }

        xhr.send()
    }

    function ajaxPUT(url, body, success, fail) {
        var xhr = new XMLHttpRequest()
        xhr.timeout = timeout
        xhr.open("PUT", url, true)

        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded')
        xhr.setRequestHeader('Content-Length', body.length)

        xhr.onload = function() {
            if(xhr.status >= 200 && xhr.status < 300) {
                success(xhr.responseText, xhr.status)
            } else {
               fail(xhr.status, xhr.responseText)
            }
        }

        xhr.onerror = function() {
            fail(xhr.status, xhr.statusText)
        }

        xhr.send(body)
    }

    function ajaxDELETE(url, body, success, fail) {
        var xhr = new XMLHttpRequest()
        xhr.timeout = timeout
        xhr.open("DELETE", url, true)

        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded')
        xhr.setRequestHeader('Content-Length', body.length)

        xhr.onload = function() {
            if(xhr.status >= 200 && xhr.status < 300) {
                success(xhr.responseText, xhr.status)
            } else {
               fail(xhr.status, xhr.responseText)
            }
        }

        xhr.onerror = function() {
            fail(xhr.status, xhr.statusText)
        }

        xhr.send(body)
    }

}
