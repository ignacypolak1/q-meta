import Qt.labs.platform
import QtQuick 6.2
import QtQuick.Controls
import QtQuick.Layouts

Button {
    width: 40
    height: parent.height
    anchors.left: mapButton.right
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
        }
        onEntered: {
            copyIcon.opacity = 0.6;
        }
        onExited: {
            copyIcon.opacity = 1;
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
