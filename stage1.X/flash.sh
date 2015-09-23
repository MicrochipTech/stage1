#!/bin/sh

set -e

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

sed "s,^Program.*$,Program \"$dir/dist/pic32mzda/production/stage1.X.production.unified.hex\"," $dir/boot_flash.cfg.in > $dir/boot_flash.cfg

$mplab_path/mdb.sh $dir/boot_flash.cfg

exit $?

