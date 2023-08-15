#!/bin/sh
WORKING_DIR=$(pwd)
sudo mkdir /usr/lib/x86_64-linux-gnu/opera/lib_extra
sudo cp $WORKING_DIR/usr/lib/opera/lib_extra/libffmpeg.so /usr/lib/x86_64-linux-gnu/opera/lib_extra/libffmpeg.so
