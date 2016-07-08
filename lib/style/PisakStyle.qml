pragma Singleton
import QtQuick 2.5
import "defaultSkin.js" as DefaultSkin
import "fancySkin.js" as FancySkin


/*!
    \qmltype PisakStyle
    \brief Style declaration for Pisak widgets.

    Singleton that stores style specification. Loads and manages various skins.
*/
QtObject {
    /*!
        \qmlproperty var PisakStyle::skin

        Current skin.
    */
    property var skin: __pickSkin().style

    function __pickSkin() {
        // TODO: load proper skin dynamically
        switch (pisak.settings.skin) {
            case "default":
            default:
                return DefaultSkin
            case "fancy":
                return FancySkin
        }
    }
}
