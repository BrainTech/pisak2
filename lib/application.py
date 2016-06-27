import sys

from PyQt5.QtCore import QSettings, QObject, pyqtProperty
from PyQt5.QtWidgets import QApplication
from PyQt5.QtQml import QQmlApplicationEngine

from .resources import Resources
from .settings import Settings


class _ApplicationContext(QObject):

    def __init__(self, parent=None):
        super().__init__(parent)
        self._resources = Resources()
        self._settings = Settings()

    @pyqtProperty(QObject, constant=True)
    def settings(self):
        return self._settings

    @pyqtProperty(QObject, constant=True)
    def resources(self):
        return self._resources


class Application:

    organization = 'pisak'

    name = 'pisak'

    def __init__(self, gui):
        self._app = QApplication(sys.argv)
        self._app.setOrganizationName(self.organization)
        self._app.setApplicationName(self.name)

        self._context = _ApplicationContext()

        self._engine = QQmlApplicationEngine()
        self._engine.rootContext().setContextProperty('pisak', self._context)
        self._engine.load(gui)

    def run(self):
        sys.exit(self._app.exec_())
