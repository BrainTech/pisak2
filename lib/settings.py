from PyQt5.QtCore import QSettings, QStandardPaths


class Settings(QSettings):

    defaults = {
        'fontCapitalization': 'AllUppercase',
        'input': 'keyboard',
        'skin': 'default'
    }

    path = QStandardPaths.writableLocation(QStandardPaths.AppConfigLocation)
    
    fileFormat = QSettings.IniFormat

    def __init__(self):
        super().__init__(self.path, self.fileFormat)
        self._loadDefaults()

    def _loadDefaults(self):
        for key, value in self.defaults.items():
            if self.value(key) is None:
                self.setValue(key, value)
