import QtQuick 2.0
import QtGraphicalEffects 1.0

Image {
    property bool rounded: true

    id: root

    layer {
        enabled: rounded
        effect: OpacityMask {
            maskSource: Item {
                width: root.width
                height: root.height
                Rectangle {
                    width: parent.width
                    height: parent.height
                    radius: Math.min(width, height)
                    anchors.centerIn: parent
                }
            }
        }
    }
}
