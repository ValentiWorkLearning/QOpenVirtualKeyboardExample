cmake_minimum_required(VERSION 3.20)

project(example-qt-virtual-keyboard)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)
set(CXX_STANDARD 17)

option (APP_DEPLOY_QT_DEPS ON)

option(USE_QTQUICKCOMPILED_RESOURCES OFF)

find_package(Qt5 COMPONENTS Quick Core Network REQUIRED)
if(USE_QTQUICKCOMPILED_RESOURCES)
    find_package(Qt5 COMPONENTS QuickCompiler REQUIRED)
    set(PROJECT_ADD_RESOURCES qtquick_compiler_add_resources)
else()
    set(PROJECT_ADD_RESOURCES qt5_add_resources)
endif()
cmake_language(CALL ${PROJECT_ADD_RESOURCES} RESOURCES ${CMAKE_CURRENT_LIST_DIR}/resources/qml.qrc )

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
)



if (WIN32)
    get_target_property(QT5_QMAKE_EXECUTABLE Qt5::qmake IMPORTED_LOCATION)
    get_filename_component(QT5_WINDEPLOYQT_EXECUTABLE ${QT5_QMAKE_EXECUTABLE} PATH)
    set(QT5_WINDEPLOYQT_EXECUTABLE "${QT5_WINDEPLOYQT_EXECUTABLE}/windeployqt.exe")

    add_custom_command(TARGET example-keyboard POST_BUILD
       COMMAND ${QT5_WINDEPLOYQT_EXECUTABLE} --qmldir ${CMAKE_SOURCE_DIR}/resources "$<$<CONFIG:Debug>:--debug>$<$<CONFIG:Release>:--release>" --no-compiler-runtime --no-translations $<TARGET_FILE_DIR:example-keyboard>)
endif()

include(InstallRequiredSystemLibraries)
   foreach(lib ${CMAKE_INSTALL_SYSTEM_RUNTIME_LIBS})
       get_filename_component(filename "${lib}" NAME)
       add_custom_command(TARGET example-keyboard POST_BUILD
           COMMAND "${CMAKE_COMMAND}" -E
               copy_if_different "${lib}" \"$<TARGET_FILE_DIR:example-keyboard>\"
       )
   endforeach()
