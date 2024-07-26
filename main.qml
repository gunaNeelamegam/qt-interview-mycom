import QtQuick
import QtWebSockets 1.4
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import "AppConstants.js" as AppConstants
import QtQuick.Layouts 1.15

ApplicationWindow {
    width: AppConstants.AppWidth
    height: AppConstants.AppHeight
    visible: true
    title: "Web Socket Client"

    id: app
    property var loaders: [home_screen, data_screen]
    property alias dataModel: messageModel

    Material.accent: Material.Blue
    Material.theme: Material.Dark


    property bool isLoading: false
    property string connection_uri: ""
    property bool isActive: false


        Loader {
            id: home_screen
            active: true
            anchors.fill: parent
            sourceComponent: ConnectionScreen {}
            asynchronous: true

        }


        Loader {
            id: data_screen
            active: true
            anchors.fill: parent
            sourceComponent: DataListScreen {}
            asynchronous: true

        }
        StackLayout {
            id: stackLayout
            height: parent.height
            currentIndex: 0
            width: parent.width
            anchors.fill: parent
            data: loaders.map(loader=>loader.item)
        }


        Timer {
            id: timer
        }

        ListModel {
            id: messageModel
        }



        WebSocket {
            id: websocket_client

            url: app.connection_uri
            active: app.isActive
            onStatusChanged:(...args)=> {
                if(WebSocket.Open === status) {
                    console.log("WEB SOCKET CONNECTION OPENED")
                        stackLayout.currentIndex = 1;

                } else if (WebSocket.Closed === status) {
                    console.log("WEB SOCKET CONNECTION CLOSED")
                           stackLayout.currentIndex = 0
                }
                else {
                   console.log(errorString)
                }

                                console.log(status)

            }

            onTextMessageReceived: {
                    try {
                        let received = JSON.parse(message)
                        messageModel.append(received)
                        console.log(received)
                    }catch(e) {
                        console.log(e?.message)

                    } finally {
                        console.log("MESSAGE : ", message, typeof message)
                    }




            }



        }

    }
