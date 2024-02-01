import Qt.labs.platform
import QtQuick 6.2
import QtQuick.Controls
import QtQuick.Layouts

Button {
    width: 60
    height: parent.height
    anchors.left: flickableElement.right
    anchors.right: parent.right

    TextEdit {
        id: textEdit

        visible: false
    }

    MouseArea {
        hoverEnabled: true
        anchors.fill: parent
        onClicked: {
            textEdit.text = value;
            textEdit.selectAll();
            textEdit.copy();
            mapLoader.latitude = metaModel.getCoordinates().x;
            mapLoader.longitude = metaModel.getCoordinates().y;
            mapLoader.source = "MetaMap.qml";
        }
        onEntered: {
            copyIcon.opacity = 0.6;
        }
        onExited: {
            copyIcon.opacity = 1;
        }
    }

    Loader {
        id: mapLoader

        property double longitude
        property double latitude

        onLoaded: {
            item.longitude = longitude;
            item.latitude = latitude;
        }
    }

    background: Rectangle {
        anchors.fill: parent
        anchors.centerIn: parent
        color: "transparent"

        Image {
            id: copyIcon

            anchors.centerIn: parent
            source: "../assets/clipboard-regular.svg"
            width: 20
            height: 20
            fillMode: Image.PreserveAspectFit
        }

    }

}
