;; This is an operating system configuration generated
;; by the graphical installer.
;;
;; Once installation is complete, you can learn and modify
;; this file to tweak the system configuration, and pass it
;; to the 'guix system reconfigure' command to effect your
;; changes.


;; Indicate which modules to import to access the variables
;; used in this configuration.
(define-module (my system vmtest)
  #:use-module (gnu)
  #:use-module (gnu packages spice)
  #:use-module (gnu services spice)
  #:use-module (gnu system)
  #:use-module (my system base)
  #:use-module (my keyboard-layout)
  #:export (%my-system-vmtest))

(define %my-system-vmtest
  (operating-system
    (inherit %base-operating-system)
    (host-name "vmtest")
    (bootloader (bootloader-configuration
                 (bootloader grub-bootloader)
                 (targets (list "/dev/sda"))
                 (keyboard-layout %my-keyboard-layout)))

    (swap-devices (list (swap-space
                         (target (uuid
                                  "109543c5-33b8-42d3-b734-b61073091c6e")))))

    (file-systems (cons* (file-system
                           (mount-point "/")
                           (device (file-system-label "vmtest-root"))
                           (type "ext4"))
                         %base-file-systems))

    (packages (cons* spice-vdagent
                     %my-system-packages))
    (services (cons*
               (service spice-vdagent-service-type)
                              %my-system-services))))

%my-system-vmtest
