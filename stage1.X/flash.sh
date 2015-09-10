#!/bin/sh

set -e

dir=$(dirname $0)
mplab_path=$(dirname $(readlink -n /usr/bin/mplab_ide))

sed "s,^Program.*$,Program \"$dir/dist/pic32mzda/production/stage1.X.production.unified.hex\"," $dir/boot_flash.cfg.in > $dir/boot_flash.cfg

$mplab_path/mdb.sh $dir/boot_flash.cfg

exit $?

