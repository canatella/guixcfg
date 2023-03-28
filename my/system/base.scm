(define-module (my system base)
  #:use-module (my keyboard-layout)
  #:use-module (gnu)
  #:use-module (gnu services spice)
  #:use-module (gnu system)
  #:use-module (gnu system nss)
  #:use-module (guix utils)
  #:use-module (gnu packages version-control)
  #:use-module (gnu packages security-token)
  #:export (%base-operating-system %my-system-services %my-system-packages))

(use-service-modules desktop sddm xorg ssh security-token)
(use-package-modules bash certs gnome emacs emacs-xyz package-management glib freedesktop ncurses file linux)

(define %my-system-services
  (modify-services
      (cons* (service gnome-desktop-service-type)
	     (service openssh-service-type)
             (service pcscd-service-type)
             (service bluetooth-service-type)
             (udev-rules-service 'fido2 libfido2 #:groups '("plugdev"))
             (udev-rules-service 'u2f libu2f-host #:groups '("plugdev"))
	     (set-xorg-configuration (xorg-configuration (keyboard-layout %my-keyboard-layout)))
         (extra-special-file "/etc/guix/channels.scm" (local-file "../base-channels.scm"))
	 %desktop-services)
      (guix-service-type config => (guix-configuration
				    (inherit config)
				    (substitute-urls (append (list "https://substitutes.nonguix.org") %default-substitute-urls))
				    (authorized-keys (append (list (plain-file "non-guix.pub" "(public-key (ecc (curve Ed25519) (q #C1FD53E5D4CE971933EC50C9F307AE2171A2D3B52C804642A7A35F84F3A4EA98#)))"))
							     %default-authorized-guix-keys)))))
)

(define %my-system-packages
  (cons*
   ;; for HTTPS access
   nss-certs
   ;; for user mounts
   gvfs
   ;; yubikey stuff
   python-yubikey-manager
   ;; tools
   git file
   ;; for clear / reset
   ncurses
   ;; for stuff not in guix
   flatpak xdg-dbus-proxy xdg-utils xdg-desktop-portal xdg-desktop-portal-gtk
   ;; key/secet manager
   seahorse
   ;; fix network manager
   libnma
   ;; utils
   strace bash-completion
   %base-packages))

(define %base-operating-system
  (operating-system

   ;; Overridden  in inherited systems
   (host-name "base")
   (bootloader (bootloader-configuration
                (bootloader grub-efi-bootloader)
                (targets '("/boot/efi"))
                (keyboard-layout keyboard-layout)))
   (file-systems  %base-file-systems)

   ;; Actual interesting stuff
   (timezone "Europe/Brussels")
   (locale "en_US.utf8")
   (keyboard-layout %my-keyboard-layout)

   (users (cons (user-account
                 (name "dam")
                 (group "dam")
	         (uid 1000)
                 (supplementary-groups '("users" "wheel" "netdev"
                                         "audio" "video" "plugdev")))
                %base-user-accounts))

   (groups (cons (user-group (name "dam") (id 1000))
                 %base-groups))

   (sudoers-file
    (plain-file "sudoers" "root ALL=(ALL) ALL\n%wheel ALL=(ALL) NOPASSWD:ALL\n"))

   (packages %my-system-packages)

   (services %my-system-services)

   (name-service-switch %mdns-host-lookup-nss)))
