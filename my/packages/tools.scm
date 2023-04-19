
(define-module (my packages tools)
  #:use-module (guix gexp)
  #:use-module (gnu packages base)
  #:use-module (gnu packages bash)
  #:use-module (guix build-system copy)
  #:use-module (guix download)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages))

(define-public circleci-cli
  (package
    (name "circleci-cli")
    (version "0.1.25725")
    (source (origin
              (method url-fetch)
              (uri (string-append "https://github.com/CircleCI-Public/circleci-cli/releases/download/v" version "/circleci-cli_" version "_linux_amd64.tar.gz"))
              (sha256
               (base32
                "1jv1nbydc7swi0d0nz50x05s7adg0r1hlgzh2b1mazvkgas7j381"))))
    (build-system copy-build-system)
    (arguments
     (list
      #:install-plan ''(("circleci" "/bin/circleci"))
                                        ;      #:validate-runpath? #f
      ))
    (home-page "https://www.circleci.com/")
    (synopsis  "CircleCI's command-line application.")
    (description "CircleCI's command-line application.")
   (license license:expat)))
