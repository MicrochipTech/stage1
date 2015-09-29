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

READLINK=`which readlink`
XC32OBJCOPY=`which xc32-objcopy`

if [ -z "$READLINK" ] ||
    [ -z "$XC32OBJCOPY" ]; then
    echo
    echo "ERROR: Missing dependencies:\n"
    echo "READLINK=$READLINK"
    echo "XC32OBJCOPY=$XC32OBJCOPY"
    echo
    exit 1
fi

dir=$(dirname $0)
mplab_path=$(dirname $(readlink -n /usr/bin/mplab_ide))

if [ ! -e "$mplab_path/prjMakefilesGenerator.sh" ]; then
    die "MPLABX install missing prjMakefilesGenerator.sh."
fi

set -e

cd $dir/
mkdir -p $dir/../uboot/
xc32-objcopy -O ihex $1/u-boot $dir/../uboot/u-boot.hex --set-start=0
$mplab_path/prjMakefilesGenerator.sh $dir
make

exit $?
