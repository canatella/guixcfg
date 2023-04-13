(define-module (my system workstation)
  #:use-module (my system base)
  #:use-module (gnu system)
  #:use-module (gnu system mapped-devices)
  #:use-module (gnu system file-systems)
  #:use-module (nongnu packages linux)
  #:export (%my-system-workstation))

(define %my-system-workstation
  (operating-system
    (inherit %base-operating-system)
    (kernel linux)
    (firmware (list linux-firmware))
    (host-name "workstation")


    (file-systems (append
                   (list (file-system
                           (device (file-system-label "guix"))
                           (mount-point "/")
                           (type "ext4"))
                         (file-system
                           (device (uuid "1C17-CB55" 'fat))
                           (mount-point "/boot/efi")
                           (type "vfat")))
                   %base-file-systems))

    ;; Specify a swap file for the system, which resides on the
    ;; root file system.
    (swap-devices (list (swap-space
                         (target (file-system-label "swap")))))

    ))

%my-system-workstation
