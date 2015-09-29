#!/bin/sh
#  Copyright 2015 Microchip Technology, Inc.
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.

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

READLINK=`which readlink`

if [ -z "$READLINK" ]; then
    echo
    echo "ERROR: Missing dependencies:\n"
    echo "READLINK=$READLINK"
    echo
    exit 1
fi

dir=$(dirname $0)
mplab_path=$(dirname $(readlink -n /usr/bin/mplab_ide))

if [ ! -e "$mplab_path/mdb.sh" ]; then
    die "MPLABX install missing mdb.sh."
fi

set -e

sed "s,^Program.*$,Program \"$dir/dist/pic32mzda/production/stage1.X.production.unified.hex\"," $dir/boot_flash.cfg.in > $dir/boot_flash.cfg

# mdb.sh may ask to accept unexpected device id, just answer yes automatically
yes y | $mplab_path/mdb.sh $dir/boot_flash.cfg

exit $?

