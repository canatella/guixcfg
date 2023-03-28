build-install-uefi:
    guix time-machine -C './my/channels.scm' -- system -L. image -t efi './my/system/install.scm'

reconfigure-home:
    guix home reconfigure home/home-configuration.scm

reconfigure-system:
    sudo guix system reconfigure system/system-configuration.scm
