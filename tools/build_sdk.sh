#!/usr/bin/env bash

set -e
set -u

echo 'cmake_minimum_required(VERSION 3.16)' > app_build/deps.cmake
for lib in $(find alire/cache -name "*.a")
do
    libname=$(basename $lib | cut -d "." -f 1)
    echo "" >> app_build/deps.cmake
    echo "add_library($libname STATIC IMPORTED GLOBAL)" >> app_build/deps.cmake
    echo "set_property(TARGET $libname PROPERTY IMPORTED_LOCATION \"\${CMAKE_SOURCE_DIR}/$lib\")" >> app_build/deps.cmake
    echo "target_link_libraries(app.elf PUBLIC $libname)" >> app_build/deps.cmake
done

basedir=$(pwd)/esp-idf

export IDF_PATH=basedir
export IDF_EXPORT_QUIET=
export IDF_ADD_PATHS_EXTRAS=
source $basedir/export.sh

# remove duplicate symbols provided by esp-idf and the Ada runtime
for sym in abort free calloc malloc
do
    riscv32-esp-elf-objcopy -N $sym app_build/obj/app
done

idf.py set-target esp32c3
idf.py build
