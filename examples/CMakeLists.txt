set(RESOURCES_PATH "${RMEDIA_ROOT_PATH}/examples/resources/")
set(INCLUDE_PATH "${RMEDIA_ROOT_PATH}/include")

function(add_example example_name source_file)
    add_executable(${example_name} ${source_file})
    target_link_libraries(${example_name} PRIVATE raylib raymedia)
    target_compile_definitions(${example_name} PRIVATE RESOURCES_PATH="${RESOURCES_PATH}")
    target_include_directories(${example_name} PRIVATE ${RAYLIB_PATH} ${INCLUDE_PATH})
endfunction()

add_example(example_01_basic "examples/example_01_basics.c")

