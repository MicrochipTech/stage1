#!/bin/sh

set -e

USAGE="USAGE: ./build_pgm <path to u-boot>"

if [ $# -ne 1 ] ; then
    echo $USAGE
    exit 1;
fi

mplab_path=$(dirname $(readlink -n /usr/bin/mplab_ide))

dir=$(dirname $0)

cd $dir/
mkdir -p $dir/../uboot/
xc32-objcopy -O ihex $1/u-boot $dir/../uboot/u-boot.hex --set-start=0
$mplab_path/prjMakefilesGenerator.sh $dir
make

exit $?
