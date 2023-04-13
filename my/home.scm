;; This "home-environment" file can be passed to 'guix home reconfigure'
;; to reproduce the content of your profile.  This is "symbolic": it only
;; specifies package names.  To reproduce the exact same profile, you also
;; need to capture the channels being used, as returned by "guix describe".
;; See the "Replicating Guix" section in the manual.

(define-module (my home)
  #:use-module (gnu)
  #:use-module (gnu home)
  #:use-module (gnu packages)
  #:use-module (gnu packages linux)
  #:use-module (gnu services)
  #:use-module (guix channels)
  #:use-module (guix gexp)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (gnu home services)
  #:use-module (gnu home services shells)
  #:use-module (gnu home services guix)
  #:use-module (my home services emacs)
  #:use-module (my home services gnupg)
  #:use-module (my gexp)
  #:use-module (nongnu packages mozilla)
  #:use-module (my packages fonts)
  #:use-module (my packages micromamba)
  #:use-module (my packages rust-apps)
  #:use-module (my packages insync)
  #:export (my-home-environment))

;;(use-modules (emacs packages melpa))
(use-package-modules curl emacs emacs-xyz gnupg password-utils python shellutils version-control rust-apps gnome gnome-xyz glib bash guile spice aspell compression web dns)


(define %my-home-environment
  (home-environment

   ;; Below is the list of packages that will show up in your
   ;; Home profile, under ~/.guix-home/profile.
   (packages (list
              ;; browser
              firefox
              ;; needed for passff firefox extension
              python password-store
              ;; usefull tools
              curl git `(,git "credential-libsecret") ripgrep fd direnv bluez
              unzip jq
              ;; dig
              `(,isc-bind "utils")
              ;; gpg
              gnupg pinentry pinentry-emacs pinentry-gnome3
              ;; gnome related stuff
              gnome-tweaks yaru-theme nordic-theme
              ;; fonts
              font-victor-mono font-ubuntu
              ;; emacs stuff
              emacs-next emacs-emacsql emacs-vterm emacs-magit emacs-pdf-tools emacs-geiser emacs-geiser-guile emacs-guix
              aspell aspell-dict-en aspell-dict-fr
              ;; needed by emacs tramp
              glibc
              ;; insync
              insync-headless
              ))

   ;; Below is the list of Home services.  To search for available
   ;; services, run 'guix home search KEYWORD' in a terminal.
   (services
    (list (service home-bash-service-type
                   (home-bash-configuration
                    (aliases '(("grep" . "grep --color=auto")
                               ("ll" . "ls -l")
                               ("ls" . "ls -p --color=auto")))
                    (bashrc (list (local-file "../home/.bashrc" "bashrc")
                                  (local-file "../home/.bashrc.readline" "bashrc-readline")
                                  (local-file "../home/.bashrc.direnv" "bashrc-direnv")
                                  (file-append emacs-vterm (string-append "/share/emacs/site-lisp/vterm-" (package-version emacs-vterm) "/etc/emacs-vterm-bash.sh"))
                                  ))
                    (bash-profile (list (local-file "../home/.bash_profile" "bash_profile")))))

          (service home-files-service-type
                   `(;; Bash completion


                     ;; GnuPG
                     (".gnupg/gpg.conf" ,(local-file "../home/gnupg/gpg.conf"))
                     (".gnupg/gpg-agent.conf" ,(local-file "../home/gnupg/gpg-agent.conf"))
                     (".gnupg/pubring.kbx" ,(local-file "../home/gnupg/pubring.kbx"))

                     ;; SSH
                     (".ssh/config" ,(local-file "../home/ssh/config"))
                     (".ssh/config_circleci" ,(local-file "../home/ssh/config_circleci"))
                     (".ssh/authorized_keys" ,(local-file "../home/ssh/authorized_keys"))
                     (".ssh/known_hosts" ,(local-file "../home/ssh/known_hosts")))
                   )

          (service home-xdg-configuration-files-service-type
                   `(
                     ;; Disable gnome ssh agent
                     ("autostart/gnome-keyring-ssh.desktop" ,(mixed-text-file "gnome-keyring-ssh.desktop"
                                                                              (read-file-like (file-append gnome-keyring "/etc/xdg/autostart/gnome-keyring-ssh.desktop"))
                                                                              "Hidden=true\n"))

                     ;; Emacs
                     ("emacs/early-init.el" ,(local-file "../home/emacs/early-init.el"))
                     ("emacs/init.el" ,(local-file "../home/emacs/init.el"))
                     ("emacs/etc" ,(local-file "../home/emacs/etc" #:recursive? #t))
                     ("emacs/cfg" ,(local-file "../home/emacs/cfg" #:recursive? #t))
                     ("emacs/lib" ,(local-file "../home/emacs/lib" #:recursive? #t))

                     ;; Some backgrounds
                     ("backgrounds" ,(local-file "../home/backgrounds" #:recursive? #t))

                     ;; Git
                     ("git/config" ,(local-file "../home/git/config"))
                     ("git/my" ,(local-file "../home/git/my"))
                     ("git/bloom" ,(local-file "../home/git/bloom"))
                     ))

          (service home-gnupg-service-type)

          (service home-emacs-service-type)

          (simple-service 'dconf-user-service
                          home-activation-service-type
                          (system (format #f "dconf load / < ~a" (string-append (current-source-directory) "/../home/dconf.ini" ))))


          (simple-service 'pass-user-service
                          home-activation-service-type
                          (system "test -d ~/.password-store || git clone dam@turris.lan:passwords.git ~/.password-store"))

          (simple-service 'firefox-user-service
                          home-activation-service-type
                          (system "test -d ~/.mozilla || git clone git@github.com:canatella/firefox-profile.git ~/.mozilla"))

          (simple-service 'flatpak-service
                          home-activation-service-type
                          #~(let ((packs '("org.gtk.Gtk3theme.Yaru-dark" "us.zoom.Zoom" "com.slack.Slack" "com.jetbrains.IntelliJ-IDEA-Community")))
                            (system* "flatpak" "--user" "remote-add" "--if-not-exists" "flathub" "https://flathub.org/repo/flathub.flatpakrepo")
                            (map (lambda (pack)
                                   (system* "flatpak" "install" "--or-update" "flathub" pack)
                                   (system* "sudo" "flatpak" "override" pack "--env=GTK_THEME=Yaru-blue-dark")
                                   (system* "sudo" "flatpak" "override" pack "--env=ICON_THEME=Yaru-blue-dark"))
                                 packs)))

          (simple-service 'variant-packages-service
                          home-channels-service-type
                          (list
                           (channel
	                    (name 'nonguix)
	                    (url "https://gitlab.com/nonguix/nonguix")
	                    (introduction
	                     (make-channel-introduction
                              "897c1a470da759236cc11798f4e0a5f7d4d59fbc"
                              (openpgp-fingerprint "2A39 3FFF 68F4 EF7A 3D29 12AF 6F51 20A0 22FB B2D5"))))
                           (channel
	                    (name 'my)
	                    (url "file:///home/dam/dm/guix-config"))))

          (simple-service 'readline-history-configuration-service
		          home-environment-variables-service-type
		          `(("HISTCONTROL" . "ignoredups:erasedups")
                            ("HISTTIMEFORMAT" . "%F %T")
                            ("HISTFILESIZE" . "-1")
                            ("HISTSIZE" . "-1")
                            ("MANPATH" . "$MANPATH:$HOME/.local/share/man")
                            ("PASSWORD_STORE_GPG_OPTS" . "--no-throw-keyids")
                            ("GUIX_LOAD_PATH" . "$HOME/dm/guix-config")
                            ("XDG_DATA_DIRS" . "$XDG_DATA_DIRS:$HOME/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share")))))))

%my-home-environment
