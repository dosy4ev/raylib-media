# Avoid infinite recursion by checking if Raylib has already been found
if (RAYLIB_FOUND)
    return()
endif()

# Allow user to specify custom include and library paths
find_path(RAYLIB_INCLUDE_DIR NAMES raylib.h PATHS
    /usr/include
    /usr/local/include
    /opt/homebrew/include  # macOS Homebrew
    $ENV{RAYLIB_INCLUDE_DIR}
)

find_library(RAYLIB_LIBRARY_RELEASE NAMES raylib PATHS
    /usr/lib
    /usr/local/lib
    /opt/homebrew/lib
    $ENV{RAYLIB_LIBRARY_DIR}
)

find_library(RAYLIB_LIBRARY_DEBUG NAMES raylibd PATHS
    /usr/lib
    /usr/local/lib
    /opt/homebrew/lib
    $ENV{RAYLIB_LIBRARY_DIR}
)

# Handle Debug/Release configurations
if (RAYLIB_LIBRARY_RELEASE OR RAYLIB_LIBRARY_DEBUG)
    add_library(raylib UNKNOWN IMPORTED)

    if (RAYLIB_LIBRARY_RELEASE)
        set_target_properties(raylib PROPERTIES IMPORTED_LOCATION_RELEASE "${RAYLIB_LIBRARY_RELEASE}")
    endif()

    if (RAYLIB_LIBRARY_DEBUG)
        set_target_properties(raylib PROPERTIES IMPORTED_LOCATION_DEBUG "${RAYLIB_LIBRARY_DEBUG}")
    endif()

    set_target_properties(raylib PROPERTIES
        INTERFACE_INCLUDE_DIRECTORIES "${RAYLIB_INCLUDE_DIR}"
    )

    set(RAYLIB_FOUND TRUE)
    message(STATUS "Raylib found: ${RAYLIB_LIBRARY_RELEASE} (Release), ${RAYLIB_LIBRARY_DEBUG} (Debug)")
else()
    set(RAYLIB_FOUND FALSE)
    message(FATAL_ERROR "Raylib not found! Install it or provide custom paths using -DRAYLIB_INCLUDE_DIR and -DRAYLIB_LIBRARY_DIR")
endif()

# Mark variables as advanced to avoid cluttering CMake GUI
mark_as_advanced(RAYLIB_INCLUDE_DIR RAYLIB_LIBRARY_RELEASE RAYLIB_LIBRARY_DEBUG)
