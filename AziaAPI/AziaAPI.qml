pragma Singleton
import QtQuick 2.0
import Qt.labs.settings 1.0

import AjaxLibrary 1.0
import Crypto 1.0

Item {
    id: _root

    readonly property string serverName: "http://localhost:3000/azia/" //"http://azia.tiksi.ru/clientapi/"
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

        Ajax.ajaxPOST(serverName+"user/register", getHeadersWithSignature(body),
                      function (responseText) {
                          console.log(responseText)
                          var json = JSON.parse(responseText)
                          if(json.status === "ok") {
                              success()
                          } else {
                              fail("Не удалось зарегистрироваться")
                          }
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

        Ajax.ajaxPOST(serverName + "user/input",  getHeadersWithSignature(body),
                      function (responseText) {
                          var json = JSON.parse(responseText)
                          if(json.status === "ok") {
                              success(responseText)
                          } else {
                              fail("")
                          }
                      },
                      function(status, statusText) {
                          fail(statusText)
                      })
    }

    function getMenu(success, fail) {
        console.log(getHeadersWithSignature({}))
        Ajax.ajaxGET(serverName + "menu", getHeadersWithSignature({}),
                     function(responseText) {
                        console.log(responseText)
                     },
                     function(status, statusText) {

                     })
    }

    function bookingTable(pointId, date, success, fail) {
        var obj = {
            "token": _root.token,
            "point_id": pointId, //в каком кафе забронировать
            "date": date.toLocaleString(Qt.locale(), "yyyy-MM-dd"),
            "time": date.toLocaleString(Qt.locale(), "hh:mm"),
            //"table_id"
        }

        var headers = getHeadersWithSignature(obj)

        console.log(JSON.stringify(headers))


        Ajax.ajaxPOST(serverName + "reserve_table", headers,
                      function (responseText) {
                          var jsonData = JSON.parse(responseText)
                          if(jsonData.status === "ok") {
                              success()
                          } else {
                              fail(jsonData, jsonData.status)
                          }
                      },
                      function(status, statusText) {
                          fail(statusText)
                      })
    }


    function updateInfo(success, fail) {
        var obj = {
            "token": _root.token
        }

        var headers = getHeadersWithSignature(obj)

        Ajax.ajaxPOST(serverName + "get_info", headers,
                      function (responseText) {
                          var json = JSON.parse(responseText)
                          if(json.status === "ok") {
                              success(json)
                          }
                          else {
                              fail("Не удалось обновить информацию")
                          }
                      },
                      function(status, statusText) {
                          fail(statusText)
                      })
    }

}
