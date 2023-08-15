#!/bin/sh
WORKING_DIR=$(pwd)
sudo mkdir /usr/lib/opera/lib_extra
sudo cp $WORKING_DIR/usr/lib/opera/lib_extra/libffmpeg.so /usr/lib/opera/lib_extra/libffmpeg.so
echo "Files installed !!!"
