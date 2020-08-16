import QtQuick 2.0
import StyleSettings 1.0
import QtGraphicalEffects 1.0

Rectangle {
    property alias image: _internalImage

    id: root
    color: "transparent"
    radius: width / 2
    border {
        width: 2
        color: Style.primaryColor
    }

    RoundImage {
        id: _internalImage
        anchors {
            fill: root
            margins: Style.tinyOffset
        }
        sourceSize {
            height: height
            width: width
        }
        smooth: true
    }
}
