# The name of your app.
# NOTICE: name defined in TARGET has a corresponding QML filename.
#         If name defined in TARGET is changed, following needs to be
#         done to match new name:
#         - corresponding QML filename must be changed
#         - desktop icon filename must be changed
#         - desktop filename must be changed
#         - icon definition filename in desktop file must be changed
TARGET = TicTacToe

CONFIG += sailfishapp c++11

SOURCES += src/TicTacToe.cpp

OTHER_FILES += qml/TicTacToe.qml \
    qml/cover/CoverPage.qml \
    rpm/TicTacToe.spec \
    rpm/TicTacToe.yaml \
    TicTacToe.desktop \
    qml/logic.js \
    qml/pages/content/Knot.qml \
    qml/pages/content/Cross.qml \
    qml/pages/MainPage.qml \
    qml/pages/content/Line.qml \
    qml/pages/content/ScoreBoard.qml \
    qml/pages/content/Settings.qml

