# Set example sources
set(EXAMPLES
    example_01_basics.c
    example_02_media_player.c
    example_03_multi_stream.c
    example_04_custom_stream.c
)

# Create an executable for each example
foreach(EXAMPLE ${EXAMPLES})
    get_filename_component(EXE_NAME ${EXAMPLE} NAME_WE)
    add_executable(${EXE_NAME} ${EXAMPLE})

    # Properly link libraries
    target_link_libraries(${EXE_NAME} PRIVATE raymedia
        debug ${RAYLIB_LIBRARY_DEBUG}
        optimized ${RAYLIB_LIBRARY_RELEASE}
        ${FFMPEG_LIBRARIES}
    )

    # Include directories
    target_include_directories(${EXE_NAME} PRIVATE 
        "${CMAKE_SOURCE_DIR}/src"
        ${FFMPEG_INCLUDE_DIRS}
        ${RAYLIB_INCLUDE_DIR}
    )
endforeach()

# Copy resources folder to the build directory
add_custom_target(copy_resources ALL
    COMMAND ${CMAKE_COMMAND} -E copy_directory
    "${CMAKE_CURRENT_SOURCE_DIR}/resources" "${CMAKE_BINARY_DIR}/resources"
)

foreach(EXAMPLE ${EXAMPLES})
    get_filename_component(EXE_NAME ${EXAMPLE} NAME_WE)
    add_dependencies(${EXE_NAME} copy_resources)
endforeach()
