#!/bin/bash

function checkfile(){
    md5 $1 | grep $CHECKSUM
    if [ $? -ne 0 ]; then
        echo "Failed to download avro, checksum didn't match"
        rm $1
        exit 1
    fi
}

AVROC_GZ=avro-c-dir/avro-c-1.7.7.tar.gz
AVRO_URL=http://psg.mtu.edu/pub/apache/avro/avro-1.7.7/c/avro-c-1.7.7.tar.gz

CHECKSUM=07a1034671c412de79e53a8f89528351

curl -o $AVROC_GZ $AVRO_URL    

checkfile $AVROC_GZ
