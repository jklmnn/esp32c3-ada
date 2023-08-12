# The following lines of boilerplate have to be in your project's CMakeLists
# in this exact order for cmake to work correctly
cmake_minimum_required(VERSION 3.16)

include($ENV{IDF_PATH}/tools/cmake/project.cmake)
project(app)

# Add the Ada code static library
add_library(ada_app STATIC IMPORTED GLOBAL)
set_property(TARGET ada_app PROPERTY IMPORTED_LOCATION "${CMAKE_SOURCE_DIR}/app_build/obj/app")
target_link_libraries(app.elf PUBLIC ada_app)

# Add the Ada run-time static library
message(STATUS "Link Ada run-time ${ada_runtime_dir}/libgnat.a")
add_library(libgnat STATIC IMPORTED GLOBAL)
set_property(TARGET libgnat PROPERTY IMPORTED_LOCATION "${CMAKE_SOURCE_DIR}/rts/adalib/libgnat.a")
target_link_libraries(app.elf PUBLIC libgnat)

#####################################
