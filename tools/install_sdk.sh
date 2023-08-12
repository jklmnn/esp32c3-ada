#!/usr/bin/env bash

set -e
set -u

basedir=$(pwd)/esp-idf

if [ ! -d $basedir ]
then
    git clone --recursive -b v5.0.3 https://github.com/espressif/esp-idf
fi

esp-idf/install.sh esp32c3

# build a custom runtime based on the bare metal riscv32 runtime
RTS_DIR=$(alr exec -- riscv64-elf-gnatls --RTS=zfp-rv32imac -v | grep "gnat$" | head -n1 | xargs)
echo src > rts/ada_source_path
echo $RTS_DIR >> rts/ada_source_path
alr exec -- gprbuild rts/rts.gpr -XBASE=$RTS_DIR --target=riscv64-elf
