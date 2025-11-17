import qs.components
import qs.services
import qs.config
import QtQuick
import QtQuick.Layouts

RowLayout {
    spacing: Appearance.spacing.small

    StyledText {
        text: Time.format(Config.services.useTwelveHourClock ? "hh:mm AP" : "HH:mm")
        font.pointSize: Appearance.font.size.normal
        color: Colours.palette.m3onSurface
    }

    StyledText {
        text: Time.format("ddd MMM dd")
        font.pointSize: Appearance.font.size.small
        color: Colours.palette.m3onSurfaceVariant
    }
}
