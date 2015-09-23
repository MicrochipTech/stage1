#!/bin/sh

set -e

USAGE="USAGE: $0 <path to u-boot>"

if [ $# -ne 1 ] ; then
    echo $USAGE
    exit 1;
fi


die()
{
    echo
    echo "ERROR: $@"
    echo
    exit 1
}

if [ ! -h /usr/bin/mplab_ide ]; then
    die "MPLABX IDE not found.  Please install."
fi

dir=$(dirname $0)
mplab_path=$(dirname $(readlink -n /usr/bin/mplab_ide))

cd $dir/
mkdir -p $dir/../uboot/
xc32-objcopy -O ihex $1/u-boot $dir/../uboot/u-boot.hex --set-start=0
$mplab_path/prjMakefilesGenerator.sh $dir
make

exit $?
