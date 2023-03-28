#!/bin/bash
echo generating channel module
guix time-machine -C './my/base-channels.scm' -- describe -f channels > './my/channels.scm'
echo generating image
guix time-machine -C './my/channels.scm' -- system -L. image -t iso9660 './my/system/install.scm'
