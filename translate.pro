# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = translate

CONFIG += sailfishapp

SOURCES += src/translate.cpp \
    src/google.cpp \
    src/t_global.cpp \
    src/yandex.cpp \
    src/deepl.cpp \
    abstract_translator.cpp

DISTFILES += qml/translate.qml \
    rpm/translate.changes.in \
    rpm/translate.changes.run.in \
    rpm/translate.spec \
    rpm/translate.yaml \
    translations/*.ts \
    translate.desktop \
    qml/pages/MainPage.qml

SAILFISHAPP_ICONS = 86x86 108x108 128x128 172x172

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

# German translation is enabled as an example. If you aren't
# planning to localize your app, remember to comment out the
# following TRANSLATIONS line. And also do not forget to
# modify the localized app name in the the .desktop file.
TRANSLATIONS += translations/translate-de.ts

HEADERS += \
    src/google.h \
    src/t_global.h \
    src/yandex.h \
    src/deepl.h \
    abstract_translator.h
