(define-module (my packages gnome)
  #:use-module (guix build-system gnu)
  #:use-module (guix download)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages))

(define-public gnome-shell-extension-cpufreq
    (package
      (name "gnome-shell-extension-cpufreq")
      (version "49.0")
      (source
       (origin
         (method url-fetch)
         (uri (string-append "https://github.com/konkor/cpufreq/archive/refs/tags/v" version ".tar.gz"))
         (sha256
          (base32
           "1i28n4bz6wrhn07vpxkr6l1ljyn7g8frp5xrr11z3z32h2hxxcd6"))))
      (build-system gnu-build-system)
      (arguments
       '(#:tests? #f                ; no test target
         #:make-flags (list (string-append "EXTENSIONS_DIR="
                                           (assoc-ref %outputs "out")
                                           "/share/gnome-shell/extensions"))
         ;;#:phases
         ;;(modify-phases %standard-phases
         ;;  ;;(delete 'configure)      ; no configure script
         ;;  (replace 'install
         ;;    (lambda* (#:key outputs #:allow-other-keys)
         ;;      (let ((out (assoc-ref outputs "out"))
         ;;            (pre "/share/gnome-shell/extensions/")
         ;;            (dir "hide-app-icon@mrapp.sourceforge.com"))
         ;;        (copy-recursively dir (string-append out pre dir))
         ;;        #t))))))
         ;;(native-inputs  (list `(,glib "bin") intltool))
         ;;(propagated-inputs (list glib))
         ))
      (synopsis "CPU Monitor and Power Manager")
      (description "This is a lightweight CPU scaling monitor and a powerful CPU management tool using standard cpufreq kernel modules to collect information and manage governors.")
      (home-page "https://konkor.github.io/cpufreq/")
      (license license:gpl3)))

gnome-shell-extension-cpufreq
