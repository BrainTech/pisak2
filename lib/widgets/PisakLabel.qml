import QtQuick 2.5
import QtQuick.Controls 1.4
import ".."


Label {
    font.pixelSize: PisakGlobals.fontPixelSize
    font.capitalization: Font[pisak.settings.fontCapitalization || "MixedCase"]
    elide: Text.ElideRight
    verticalAlignment: Text.AlignVCenter
    horizontalAlignment: Text.AlignHCenter
}
