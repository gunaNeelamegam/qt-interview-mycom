import QtQuick
import QtWebSockets 1.4
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import "AppConstants.js" as AppConstants
import QtQuick.Layouts 1.15

Item {
id: screen
Layout.fillHeight: true
Layout.fillWidth: true
anchors.fill: parent


property int modelIndex: index
ColumnLayout {
    anchors.fill: parent
    PaddedRectangle {
        id: login_title
        height: 50
        color: Material.accentColor.darker()
        Layout.fillWidth: true
        radius: 10
        Layout.leftMargin: 10
        Layout.rightMargin: 10
        Label {
            id: login
            anchors.centerIn: parent
            text: "Connection"
            font.bold: true
            font.pixelSize: 25
        }
    }

    ColumnLayout {
        id: connection_lay
        Layout.leftMargin: 20
        Layout.rightMargin: 20
        Layout.fillWidth: true

        Label {
            id: connection_lbl
            text: "Conection Uri"
            font.bold: true
            font.pixelSize: 15

        }
        RowLayout {
            id: user_name
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignLeading | Qt.AlignVCenter

            TextField {
                id: connection
                Layout.fillWidth: true
                text: connection_uri
                onTextChanged: (...args) => {
                                  connection_uri = text;
                               }
            }
        }
    }

    BusyIndicator {
        id: loadingIndicator
        visible: isLoading
        Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
        width: 10
        height: 10
    }

    Button {
        id: connect_btn
        visible: !isLoading
        text: qsTr("Connect")
        //                        highlighted: true
        Material.foreground: Material.Blue
        font.bold: true
        font.pixelSize:15
        Layout.fillWidth: true
        Layout.leftMargin: 30
        Layout.rightMargin: 30
        enabled: !isLoading
        //                        y: password_lay.y + password_lay.height + 30
        Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
        //                        x: (parent.width + contentItem.width) * 0.33

        function onConnection() {
                websocket_client.url = connection_uri
            websocket_client.active = true;
        }

        Component.onCompleted: {
            connect_btn.clicked.connect(onConnection)
        }
    }
}
}
