
(define-module (my packages tools)
  #:use-module (gnu packages base)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages java)
  #:use-module (gnu packages libusb)
  #:use-module (gnu packages python-build)
  #:use-module (gnu packages python-crypto)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages security-token)
  #:use-module (guix build-system copy)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system pyproject)
  #:use-module (guix build gnu-build-system)
  #:use-module (guix build utils)
  #:use-module (guix download)
  #:use-module (guix gexp)
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


(define my-python-pyscard
  (package
    (inherit python-pyscard)
    (version "2.0.7")
    (source (origin
              (method url-fetch)
              ;; The maintainer publishes releases on various sites, but
              ;; SourceForge is apparently the only one with a signed release.
              (uri (string-append
                    "mirror://sourceforge/pyscard/pyscard/pyscard%20"
                    version "/pyscard-" version ".tar.gz"))
              (sha256
               (base32
                "1gy1hmzrhfa7bqs132v89pchm9q3rpnqf3a6225vwpx7bx959017"))))))



(define-public kotlin-language-server
  (package
    (name "kotlin-language-server")
    (version "1.3.3")
    (source (origin
              (method url-fetch)
              (uri (string-append "https://github.com/fwcd/kotlin-language-server/releases/download/" version "/server.zip"))
              (file-name (string-append name "-" version ".zip"))
              (sha256
               (base32
                "1q0z13q7q2s98bhvbdnn44n1wq5aszr7ra436vbz2d6c9spinncr"))))
    (build-system copy-build-system)
    (inputs
     (list openjdk11))
    (home-page "https://github.com/fwcd/kotlin-language-server")
    (synopsis  "")
    (description "")
    (license license:expat)))

kotlin-language-server
