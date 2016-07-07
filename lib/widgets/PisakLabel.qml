import QtQuick 2.5
import QtQuick.Controls 1.4


Label {
    font.capitalization: Font[pisak.settings.fontCapitalization || "AllUppercase"]
    elide: Text.ElideRight
    verticalAlignment: Text.AlignVCenter
    horizontalAlignment: Text.AlignHCenter
}
