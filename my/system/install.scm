
(define-module (my system install)
  #:use-module (my keyboard-layout)
  #:use-module (gnu bootloader)
  #:use-module (gnu bootloader grub)
  #:use-module (gnu packages curl)
  #:use-module (gnu packages version-control)
  #:use-module (gnu packages emacs)
  #:use-module (gnu services)
  #:use-module (gnu system)
  #:use-module (gnu system install)
  #:use-module (guix gexp)
  #:use-module (nongnu packages linux)
  #:export (my-installation-os))

(define my-installation-os
  (operating-system
    (inherit installation-os)
    (kernel linux)
    (firmware (list linux-firmware))
    (timezone "Europe/Brussels")
    (keyboard-layout %my-keyboard-layout)
    (bootloader (bootloader-configuration
                 (bootloader grub-bootloader)
                 (targets '("/dev/sda"))
                 (keyboard-layout keyboard-layout)))

    (services
     (cons*
      ;; Include the channel file so that it can be used during installation.
      (extra-special-file "/etc/guix/channels.scm" (local-file "../channels.scm"))
      (operating-system-user-services installation-os)))

    (packages
     (append
      (list curl git emacs-no-x-toolkit)
      (operating-system-packages installation-os)))

    ))

my-installation-os
