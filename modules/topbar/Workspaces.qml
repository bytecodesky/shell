pragma ComponentBehavior: Bound

import qs.components
import qs.services
import qs.config
import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

RowLayout {
    id: root

    required property ShellScreen screen

    spacing: Appearance.spacing.small

    Repeater {
        model: Config.bar.workspaces.shown

        StyledRect {
            required property int index

            readonly property int workspaceId: index + 1
            readonly property var workspace: Hypr.workspaces.values.find(ws => ws.id === workspaceId)
            readonly property bool isActive: {
                const mon = Hypr.monitorFor(root.screen);
                return mon?.activeWorkspace?.id === workspaceId;
            }
            readonly property bool isOccupied: workspace !== undefined

            Layout.preferredWidth: 25
            Layout.preferredHeight: 25

            radius: Appearance.rounding.small
            color: isActive ? Colours.palette.m3primary : (isOccupied ? Colours.palette.m3surfaceContainerHighest : "transparent")
            border.width: 1
            border.color: Colours.palette.m3outline

            Behavior on color {
                Anim {}
            }

            StyledText {
                anchors.centerIn: parent
                text: parent.workspaceId.toString()
                size: Appearance.font.size.small
                color: parent.isActive ? Colours.palette.m3onPrimary : Colours.palette.m3onSurface
            }

            MouseArea {
                anchors.fill: parent
                onClicked: Hypr.dispatch(`workspace ${parent.workspaceId}`)
            }
        }
    }
}
