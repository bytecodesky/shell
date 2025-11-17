pragma ComponentBehavior: Bound

import qs.components
import qs.services
import qs.config
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

Variants {
    model: Quickshell.screens

    Scope {
        id: scope

        required property ShellScreen modelData

        StyledWindow {
            id: win

            screen: scope.modelData
            name: "topbar"
            WlrLayershell.layer: WlrLayer.Top
            WlrLayershell.exclusionMode: ExclusionMode.Normal
            WlrLayershell.exclusiveZone: barContent.shouldShow ? barHeight + Config.border.thickness : 0
            WlrLayershell.keyboardFocus: WlrKeyboardFocus.None

            readonly property int barHeight: 35
            readonly property bool hovered: hoverArea.containsMouse

            anchors.top: true
            anchors.left: true
            anchors.right: true

            height: barHeight + Config.border.thickness

            color: "transparent"

            // Top border
            StyledRect {
                id: border
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                height: Config.border.thickness
                color: Colours.palette.m3primary
                visible: barContent.shouldShow
            }

            // Main bar content
            StyledRect {
                id: barContent

                property bool persistent: false
                readonly property bool shouldShow: persistent || win.hovered

                anchors.top: border.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                implicitHeight: win.barHeight

                height: shouldShow ? implicitHeight : 0
                visible: height > 0
                clip: true
                color: Colours.palette.m3surfaceContainer
                opacity: Colours.transparency.enabled ? Colours.transparency.base : 1

                Behavior on height {
                    Anim {
                        duration: Appearance.anim.durations.expressiveDefaultSpatial
                        easing.bezierCurve: shouldShow ? Appearance.anim.curves.expressiveDefaultSpatial : Appearance.anim.curves.emphasized
                    }
                }

                RowLayout {
                    anchors.fill: parent
                    anchors.leftMargin: Appearance.padding.normal
                    anchors.rightMargin: Appearance.padding.normal
                    spacing: Appearance.spacing.normal

                    // Left section - Workspaces
                    Workspaces {
                        Layout.alignment: Qt.AlignVCenter
                        screen: scope.modelData
                    }

                    // Center spacer
                    Item {
                        Layout.fillWidth: true
                    }

                    // Right section - Status items
                    Clock {
                        Layout.alignment: Qt.AlignVCenter
                    }

                    StatusIcons {
                        Layout.alignment: Qt.AlignVCenter
                    }
                }
            }

            // Hover detection area at the top edge
            MouseArea {
                id: hoverArea
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                height: barContent.shouldShow ? parent.height : 5
                hoverEnabled: true
                acceptedButtons: Qt.NoButton
            }
        }
    }
}
