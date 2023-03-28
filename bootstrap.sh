#!/usr/bin/env bash
set -euo pipefail

HERE="$(dirname "$0")"

# Install non guix
mkdir -p ~/.config/guix
cp ${HERE}/channels.scm ~/.config/guix/channels.scm

#guix pull
#hash guix

# Reconfigure system
#guix system reconfigure "-L${HERE}" \
#     --substitute-urls='https://ci.guix.gnu.org https://bordeaux.guix.gnu.org https://substitutes.nonguix.org' \
#     "${HERE}/my/systems/${1}.scm"


su dam -c "guix home reconfigure '-L${HERE}' '${HERE}/home/home-configuration.scm'"

# Cleanup
#guix package --delete-generations
#guix gc
