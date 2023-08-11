#!/usr/bin/env bash

set -e
set -u

basedir=$(pwd)/esp-idf

if [ ! -d $basedir ]
then
    git clone --recursive -b v5.0.3 https://github.com/espressif/esp-idf
fi

esp-idf/install.sh esp32c3
