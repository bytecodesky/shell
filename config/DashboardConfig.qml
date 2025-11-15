import Quickshell.Io

JsonObject {
    property bool enabled: true
    property bool showOnHover: true
    property int dragThreshold: 50
    property Sizes sizes: Sizes {}

    component Sizes: JsonObject {
        readonly property int tabIndicatorHeight: 3
        readonly property int tabIndicatorSpacing: 5
        readonly property int infoWidth: 200
        readonly property int infoIconSize: 25
        readonly property int dateTimeWidth: 110
        readonly property int resourceProgessThickness: 10
        readonly property int weatherWidth: 250
        readonly property int resourceSize: 200
    }
}
