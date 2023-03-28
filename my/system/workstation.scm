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


    ;; The UUID is that returned by 'cryptsetup luksUUID'.
    (mapped-devices
     (list (mapped-device
            (source (uuid "7dde4397-d345-4155-bd62-616d4dff5bdb"))
            (target "system-root")
            (type luks-device-mapping))))

    (file-systems (append
                   (list (file-system
                           (device (file-system-label "system-root"))
                           (mount-point "/")
                           (type "ext4")
                           (dependencies mapped-devices))
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
