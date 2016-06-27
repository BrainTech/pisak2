pragma Singleton
import QtQuick 2.5
import "defaultSkin.js" as DefaultSkin
import "fancySkin.js" as FancySkin


QtObject {
    property var skin: __pickSkin().style

    function __pickSkin() {
        // TODO: load proper skin dynamically
        switch (pisak.settings.skin) {
            case "default":
                return DefaultSkin
            case "fancy":
            default:
                return FancySkin
        }
    }
}
