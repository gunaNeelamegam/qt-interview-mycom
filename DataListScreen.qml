import QtQuick
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
   id:dataScreen
    anchors.fill: parent
    ListView {
        id: messageList
        anchors.fill: parent
        model: app.dataModel
        delegate: Item {
            id: message
             width: parent.width
             height: 50
             RowLayout {
                 spacing: 10
                 anchors.fill: parent
                 Text {
                     id: line
                     Layout.alignment: Qt.AlignLeading
                     text:model.line
                 }

                 Text {
                     id: date
                     Layout.alignment: Qt.AlignHCenter
                     text: model.date
                 }
                 Text {
                     id: value
                     Layout.alignment: Qt.AlignTrailing
                     text: model.value
                 }

             }

             Rectangle {
                 id: separator
                 width: parent.width
                 height: 3
             }
             Component.onCompleted: {
                 console.log(model)
             }
        }
    }

    Component.onCompleted: {
        console.log(app.dataModel)
    }
}
