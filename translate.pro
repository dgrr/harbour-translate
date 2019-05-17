include ($$PWD/libQtQmlTricks/libQtQmlTricks-3.0.pri)

TARGET = translate

CONFIG += sailfishapp

QT += gui core network qml quick

QMAKE_CFLAGS -= -g
QMAKE_CFLAGS_DEBUG -= -g
QMAKE_CFLAGS_RELEASE -= -g
QMAKE_CFLAGS_RELEASE_WITH_DEBUGINFO -= -g

QMAKE_CXXFLAGS -= -g
QMAKE_CXXFLAGS_DEBUG -= -g
QMAKE_CXXFLAGS_RELEASE -= -g
QMAKE_CXXFLAGS_RELEASE_WITH_DEBUGINFO -= -g

PKGCONFIG += sailfishapp

SOURCES += src/translate.cpp \
    src/google.cpp \
    src/t_global.cpp \
    src/yandex.cpp \
    src/deepl.cpp \
    src/abstract_translator.cpp \
    language.cpp

DISTFILES += qml/translate.qml \
    rpm/translate.changes.in \
    rpm/translate.changes.run.in \
    rpm/translate.spec \
    rpm/translate.yaml \
    translations/*.ts \
    translate.desktop \
    qml/components/RightPage.qml \
    qml/components/LabelFixed.qml

SAILFISHAPP_ICONS = 86x86 108x108 128x128 172x172

CONFIG += sailfishapp_i18n

TRANSLATIONS += translations/translate-de.ts

HEADERS += \
    src/google.h \
    src/t_global.h \
    src/yandex.h \
    src/deepl.h \
    src/abstract_translator.h \
    language.h

RESOURCES += \
    qml.qrc
