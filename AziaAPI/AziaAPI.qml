pragma Singleton
import QtQuick 2.0
import Qt.labs.settings 1.0

import AjaxLibrary 1.0
import Crypto 1.0

Item {
    id: _root

    readonly property string host: "https://localhost"
    readonly property string urlAPI: host + "/aziaclient" //"http://azia.tiksi.ru/clientapi/"
    readonly property string apiKey: "5a20fbce-fdd6-40ea-84fb-b6c1d75fd368"


    Component.onCompleted: {
        //console.log("token:", token)
    }

    Settings {
        //property alias token: _root.token
    }


    function getSignature(params) {
        var ordered = {}, i;

        Object.keys(params).sort().forEach(function(key) {
            ordered[key] = params[key];
        });

        var signature = _root.apiKey;

        for(i in ordered) {
            if(typeof ordered[i] === 'undefined' || ordered[i] === null || ordered[i] === '')
                continue;
            signature = signature + "|" + ordered[i]
        }

        return Crypto.sha1(signature);
    }

    function getHeadersWithSignature(obj) {
        obj.signature = getSignature(obj)

        var sendData = []
        for(var i in obj) {
            sendData.push(i + '=' + obj[i])
        }
        sendData = sendData.join("&")
        return sendData
    }

    function registration(obj, success, fail) {
        //проверить на заполненость полей (номер телефона)

        var body = {
            "name": obj.name,
            "phoneNumber": obj.phoneNumber,
            "password": Crypto.sha1(obj.password + "|" + _root.apiKey),
            "address": obj.address
        }

        Ajax.ajaxPOST(urlAPI+"/user/register", getHeadersWithSignature(body),
                      function (responseText) {
                          success()
                      },
                      function(status, statusText) {
                          fail(statusText)
                      })
    }

    function authentication(obj, success, fail) {
        //проверить что бы в obj были phoneNubmer и password не пустыми

        var body = {
            "phoneNumber": obj.phoneNumber,
            "password": Crypto.sha1(obj.password + "|" + _root.apiKey)
        }


        Ajax.ajaxPOST(urlAPI + "/user/input",  getHeadersWithSignature(body),
                      function (responseText) {                          
                          success(responseText)
                      },
                      function(status, statusText) {
                          fail(statusText)
                      })
    }

    function getMenu(success, fail) {

        Ajax.ajaxGET(urlAPI + "/menu", getHeadersWithSignature({}),
                     function(responseText) {
                         success(responseText)
                     },
                     function(status, statusText) {
                         fail()
                     })
    }

    function ordered(obj, success, fail) {

        var body = getHeadersWithSignature(obj)


        Ajax.ajaxPOST(urlAPI + "/orders", body,
                      function (responseText) {
                          var jsonUser = JSON.parse(responseText)
                          success(responseText)
                      },
                      function(status, statusText) {
                          fail(status, statusText)
                      })
    }

    function getEvents(success, fail) {
        Ajax.ajaxGET(urlAPI + "/events", getHeadersWithSignature({}),
                     function(responseText) {
                         success(responseText)
                     },
                     function(status, statusText) {
                         fail()
                     })
    }

}
