pragma ComponentBehavior: Bound

import qs.components
import qs.services
import qs.utils
import qs.config
import Quickshell.Services.UPower
import QtQuick
import QtQuick.Layouts

RowLayout {
    spacing: Appearance.spacing.normal

    // Network icon
    Loader {
        active: Config.bar.status.showNetwork && Network.active !== null
        visible: active

        sourceComponent: MaterialIcon {
            text: Network.active ? Icons.getNetworkIcon(Network.active.strength ?? 0) : "wifi_off"
            color: Colours.palette.m3onSurface
        }
    }

    // Battery icon
    Loader {
        active: Config.bar.status.showBattery && UPower.displayDevice.isLaptopBattery
        visible: active

        sourceComponent: RowLayout {
            spacing: Appearance.spacing.smaller

            MaterialIcon {
                text: {
                    const perc = UPower.displayDevice.percentage;
                    const charging = [UPowerDeviceState.Charging, UPowerDeviceState.FullyCharged, UPowerDeviceState.PendingCharge].includes(UPower.displayDevice.state);
                    if (perc === 1)
                        return charging ? "battery_charging_full" : "battery_full";
                    let level = Math.floor(perc * 7);
                    if (charging && (level === 4 || level === 1))
                        level--;
                    return charging ? `battery_charging_${(level + 3) * 10}` : `battery_${level}_bar`;
                }
                color: !UPower.onBattery || UPower.displayDevice.percentage > 0.2 ? Colours.palette.m3onSurface : Colours.palette.m3error
                fill: 1
            }

            StyledText {
                text: `${Math.round(UPower.displayDevice.percentage * 100)}%`
                font.pointSize: Appearance.font.size.small
                color: Colours.palette.m3onSurfaceVariant
            }
        }
    }
}
