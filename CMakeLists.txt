cmake_minimum_required(VERSION 3.12)

# Prefer GCC/G++, and search for it if it's not the default on the path
find_program(CMAKE_C_COMPILER NAMES $ENV{CC} gcc PATHS ENV PATH NO_DEFAULT_PATH)
find_program(CMAKE_CXX_COMPILER NAMES $ENV{CXX} g++ PATHS ENV PATH NO_DEFAULT_PATH)

project(ManabuDesktop CXX)

# Find GTK+ headers/libs with PkgConfig
find_package(PkgConfig REQUIRED)
pkg_check_modules(GTKMM REQUIRED gtkmm-3.0)

# Generated paths starting with "C:" need to be converted to /c/ to work with MSYS2
# TODO remove this or do it some way better at some point in the future
if(MSYS OR MINGW)
	string(REGEX REPLACE "C:" "/c/" GTKMM_INCLUDE_DIRS "${GTKMM_INCLUDE_DIRS}")
endif(MSYS OR MINGW)

include_directories(${GTKMM_INCLUDE_DIRS} ../libmanabu/build/lib/)
link_directories(${GTKMM_LIBRARY_DIRS} ../libmanabu/build/include/)

# Add other flags to the compiler
add_definitions(${GTKMM_CFLAGS_OTHER})

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/res)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/bin)

set(MANABU_DESKTOP_CXX_FILES
	${PROJECT_SOURCE_DIR}/src/main.cpp
	${PROJECT_SOURCE_DIR}/src/manabu/desktop/gresources.c
	${PROJECT_SOURCE_DIR}/src/manabu/desktop/login.cpp
)

set_source_files_properties(${PROJECT_SOURCE_DIR}/src/manabu/desktop/gresources.c PROPERTIES LANGUAGE CXX)

add_custom_command(
	OUTPUT ${PROJECT_SOURCE_DIR}/src/manabu/desktop/gresources.c
	COMMAND glib-compile-resources --target=${PROJECT_SOURCE_DIR}/src/manabu/desktop/gresources.c --generate-source ${PROJECT_SOURCE_DIR}/layouts/gresources.xml
	DEPENDS ${SOURCE_FILES}
	WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}/layouts
)

# Generate the ManabuDesktop executable
add_executable(ManabuDesktop ${MANABU_DESKTOP_CXX_FILES})

# Link to libraries
target_link_libraries(ManabuDesktop ${GTKMM_LIBRARIES})
