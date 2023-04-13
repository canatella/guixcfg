(define-module (my packages fonts)
  #:use-module ((gnu packages fonts) #:prefix upstream:)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system font))

(define-public font-ubuntu
  (package
    (name "font-ubuntu")
    (version "0.83")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://salsa.debian.org/fonts-team/fonts-ubuntu")
                    (commit (string-append "upstream/" version))))
              (file-name (git-file-name name version))
              (sha256
               (base32
                "1d2xrjpxy70f3nsgqiggwv6pj06qglf5vj2847pqx60w3ygi903g"))))
    (build-system font-build-system)
    (home-page "http://font.ubuntu.com/")
    (synopsis "The Ubuntu Font Family")
    (description "The Ubuntu Font Family is a unique, custom designed font
that has a very distinctive look and feel.  This package provides the
TrueType (TTF) files.")
    (license
     (license:non-copyleft
      "http://font.ubuntu.com/ufl/ubuntu-font-licence-1.0.txt"
      "Ubuntu Font License v1.0"))))

(define-public font-victor-mono
  (package
    (inherit upstream:font-victor-mono)
    (arguments
     `(#:phases
       (modify-phases %standard-phases
         (add-after 'unpack 'remove-oblique
           (lambda* ( #:key source #:allow-other-keys)
             (let ((variants '("" "Thin" "ExtraLight" "Light" "Medium" "SemiBold" "Bold")))
               (map (lambda (variant)
                      (delete-file (format #f "EOT/VictorMono-~aOblique.eot" variant))
                      (delete-file (format #f "WOFF2/VictorMono-~aOblique.woff2" variant))
                      (delete-file (format #f "OTF/VictorMono-~aOblique.otf" variant))
                      (delete-file (format #f "TTF/VictorMono-~aOblique.ttf" variant))
                      (delete-file (format #f "WOFF/VictorMono-~aOblique.woff" variant))) variants)))))))))
