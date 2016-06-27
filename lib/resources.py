import os.path

from PyQt5.QtCore import QObject, QStandardPaths, QDir, pyqtSlot


class Resources(QObject):

    resDir = os.path.abspath('res')

    appDataDir = QStandardPaths.writableLocation(QStandardPaths.AppDataLocation)

    soundFileExt = '.wav'

    @pyqtSlot(str, result=str)
    def getSoundPath(self, soundName):
        soundFile = soundName + self.soundFileExt
        path = os.path.join(self.appDataDir, soundFile)
        if not os.path.exists(path):
            path = os.path.join(self.resDir, soundFile)
        return path
