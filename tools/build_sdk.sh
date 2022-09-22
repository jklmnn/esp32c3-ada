#!/usr/bin/env bash

set -e
set -u

basedir=$(pwd)/esp-idf

export IDF_PATH=basedir
export IDF_EXPORT_QUIET=
source $basedir/export.sh

idf.py set-target esp32c3
idf.py build
