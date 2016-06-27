from lib.application import Application

from PyQt5.QtWidgets import QApplication


if __name__ == '__main__':

    # to be able to close the app from terminal with
    # ctr+c we have to do the following:
    import signal
    signal.signal(signal.SIGINT, signal.SIG_DFL)
    # ------------------------------------------

    gui = 'main.qml'
    app = Application(gui)
    app.run()
