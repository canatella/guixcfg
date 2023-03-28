#!/bin/sh

if [ -z "$1" ]; then
    echo "install.sh (vmtest|workstation)"
    exit 1
fi

HERE="$(dirname "$0")"

#herd start cow-store /mnt
#guix pull
#hash guix
guix system "-L${HERE}" init --substitute-urls='https://ci.guix.gnu.org https://bordeaux.guix.gnu.org https://substitutes.nonguix.org' \
     "${HERE}/my/system/${1}.scm" /mnt
