#!/usr/bin/env bash

set -e
set -u

basedir=$(pwd)/esp-idf

if [ ! -d $basedir ]
then
    git clone --recursive https://github.com/espressif/esp-idf
fi

IDF_PATH=$(cd "${basedir}"; pwd -P)
export IDF_PATH

echo "Detecting the Python interpreter"
. "${IDF_PATH}/tools/detect_python.sh"

echo "Checking Python compatibility"
"${ESP_PYTHON}" "${IDF_PATH}/tools/python_version_checker.py"

TARGETS="esp32c3"

echo "Installing ESP-IDF tools"
"${ESP_PYTHON}" "${IDF_PATH}/tools/idf_tools.py" install --targets=${TARGETS}

FEATURES=`"${ESP_PYTHON}" "${IDF_PATH}/tools/install_util.py" extract features "$@"`

echo "Installing Python environment and packages"
"${ESP_PYTHON}" "${IDF_PATH}/tools/idf_tools.py" install-python-env --features=${FEATURES}

echo "All done! You can now run:"
echo ""
echo "  . ${basedir}/export.sh"
echo ""
