cmake_minimum_required(VERSION 3.20)

project(example-qt-virtual-keyboard)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)
set(CXX_STANDARD 17)

find_package(Qt5 COMPONENTS Quick Core Network)
qt5_add_resources( RESOURCES  resources/qml.qrc )

add_subdirectory(OpenVirtualKeyboard)

add_executable(example-keyboard ${PROJECT_SOURCES} ${RESOURCES})

target_sources(
    example-keyboard
    PRIVATE
    main.cpp
)

target_compile_features(
    example-keyboard
    PRIVATE
    cxx_std_17
)

target_link_libraries(
    example-keyboard
    PRIVATE
    Qt5::Core
    Qt5::Quick
#    OpenVirtualKeybaord
)
