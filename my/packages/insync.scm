(define-module (my packages insync)
  #:use-module (guix gexp)
  #:use-module (gnu packages base)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages certs)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages debian)
  #:use-module (gnu packages gcc)
  #:use-module (gnu packages linux)
  #:use-module (guix build-system copy)
  #:use-module (guix download)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
)

(define-public insync-headless
  (package
    (name "insync-headless")
    (version "3.2.7.10758")
    (source (origin
              (method url-fetch)
              (uri (string-append "https://cdn.insynchq.com/builds/linux/insync-headless_" version "-buster_amd64.deb"))
              (file-name (string-append name "-" version ".deb"))
              (sha256
               (base32
                "1yqly0yy0rv7q4hh5k8licclrbrd5iq6afw20wfidi1q62jidc7m"))))
    (build-system copy-build-system)
    (arguments
     (list
      #:install-plan ''(("usr/" ""))
      #:validate-runpath? #f
      #:phases
           #~(modify-phases %standard-phases
               (replace 'unpack
                 (lambda* (#:key source #:allow-other-keys)
                   (invoke "dpkg-deb" "-X" source ".")))
               (add-after 'install 'insync-wrapper
                 (lambda* (#:key inputs outputs #:allow-other-keys)
                   (let* ((dst (assoc-ref outputs "out"))
                          (bin (string-append dst "/bin/insync-headless"))
                          (wrapper (string-append dst "/lib-exec/insync-wrapper"))
                          (pgrep (string-append dst "/lib-exec/pgrep"))
                          (ps (string-append dst "/lib-exec/ps"))
                          (sh (which "bash")))
                     (mkdir-p (string-append dst "/bin"))
                     (mkdir-p (string-append dst "/lib-exec"))
                     (call-with-output-file wrapper
                       (lambda (port)
                         (format port(string-append
                                      "#!" sh "\n"
                                      "export LD_LIBRARY_PATH=" #+(file-append (this-package-input "gcc") "/lib") "\n"
                                      "export LC_TIME=C\n"
                                      "export PATH=" dst "/lib-exec:$PATH\n"
                                      "exec "(search-input-file outputs "lib/insync/insync-headless") " \"$@\"\n"
                                      ))))
                     (chmod wrapper #o755)
                     (call-with-output-file ps
                       (lambda (port)
                         (format port(string-append
                                      "#!" sh "\n"
                                      "id -u\n"
                                      "exit 0\n"
                                      ))))
                     (chmod ps #o755)
                     (call-with-output-file pgrep
                       (lambda (port)
                         (format port(string-append
                                      "#!" sh "\n"
                                      "exit 0\n"
                                      ))))
                     (chmod pgrep #o755)
                     (call-with-output-file  bin
                       (lambda (port)
                         (format port
                                 (string-append
                                  "#!" sh "\n"
                                  "cd $HOME\n"
                                  "guix shell --emulate-fhs --container --network"
                                  " --preserve='^HOME$' --preserve='^XDG_'"
                                  " --expose=/etc/machine-id --share=/tmp"
                                  " zlib gcc:lib nss-certs bash procps coreutils insync-headless -- "
                                  wrapper " \"$@\"\n"))))
                     (chmod bin #o755))
                   #t))
               )))
    (inputs (list `(,gcc "lib") zlib nss-certs bash procps coreutils))
    (native-inputs (list dpkg))
    (home-page "https://www.insynchq.com/")
    (synopsis
     "")
    (description
     "")
   (license (license:non-copyleft
           "https://www.insynchq.com/"
           "Insync proprietary license."))))
insync-headless
