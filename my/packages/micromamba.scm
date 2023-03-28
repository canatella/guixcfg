(define-module (my packages micromamba)
  #:use-module (guix build-system cmake)
  #:use-module (guix download)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (gnu packages backup)
  #:use-module (gnu packages cmake)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages cpp)
  #:use-module (gnu packages crypto)
  #:use-module (gnu packages curl)
  #:use-module (gnu packages logging)
  #:use-module (gnu packages ninja)
  #:use-module (gnu packages pretty-print)
  #:use-module (gnu packages python)
  #:use-module (gnu packages serialization)
  #:use-module (gnu packages tls))

(define zstd-cmake
  (package
    (inherit zstd)
    (name "zstd-cmake")
    (build-system cmake-build-system)
    (arguments
     `(#:cmake ,cmake
       #:tests? #f
       #:configure-flags (list (string-append "-S../zstd-" "1.5.0" "/build/cmake"))))))

(define reproc-cpp
  (package
    (inherit reproc)
    (arguments
     `(#:tests? #f
       #:configure-flags (list "-DREPROC++=ON")))
    ))

(define-public libsolv
  (package
    (name "libsolv")
    (version "0.7.23")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/openSUSE/libsolv.git")
                    (commit version)))
              (file-name (git-file-name name version))
              (sha256
               (base32 "12z63kcna9swh3vzxk3sac0l4by5z8q22wip9cyq5b7wp9m3hn4b"))))
    (native-inputs `(("zlib" ,zlib)))
    (build-system cmake-build-system)
    (arguments
     `(#:configure-flags `("-DENABLE_STATIC=ON"
                           "-DENABLE_CONDA=ON")))
    (synopsis "Package dependency solver using a satisfiability algorithm")
   (description "Package dependency solver using a satisfiability algorithm")
   (home-page "https://github.com/openSUSE/libsolv")
   (license license:bsd-3)))

(define cli11-2.3
  (package
    (inherit cli11)
    (version "2.3.2")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
              (url "https://github.com/CLIUtils/CLI11")
              (commit (string-append "v" version))))
        (file-name (git-file-name "cli11" version))
        (sha256
         (base32 "1iif7kzp3yyjqg4yfar89rqmz44xkbi603gf9kjdqbgraw3f8zy7"))))
    (arguments
     `(#:tests? #f
                #:configure-flags '("-DCLI11_BUILD_TESTS=OFF")))
))

(define-public micromamba
  (package
   (name "micromamba")
   (version "1.3.1")
   (source (origin
            (method url-fetch)
            (uri "https://github.com/mamba-org/mamba/archive/refs/tags/2023.02.09.tar.gz")
            (sha256
             (base32 "117clji74z654yaiv0c3rpq3161adb3f9734k40mw2rnm19j5q91"))))
   (build-system cmake-build-system)
   (arguments
    `(#:cmake ,cmake
      #:build-type "Release"
      #:tests? #f
      #:configure-flags `("-DBUILD_LIBMAMBA=ON"
                          "-DBUILD_MICROMAMBA=ON"
                          "-DBUILD_STATIC=ON"
                          "-DBUILD_SHARED=OFF"
                          "-DMICROMAMBA_LINKAGE=STATIC"
                          ;; better way to do this ?
                          ,(string-append "-Dzstd_DIR="  (assoc-ref %build-inputs "zstd-cmake")))
      ))



   (native-inputs `(("ninja" ,ninja)
                    ("json-modern-cxx" ,json-modern-cxx)
                    ("libarchive" ,libarchive)
                    ("libsodium" ,libsodium)
                    ("curl" ,curl)
                    ("reproc" ,reproc)
                    ("yaml-cpp" ,yaml-cpp)
                    ("cli11" ,cli11-2.3)
                    ("spdlog" ,spdlog)
                    ("fmt" ,fmt)
                    ("python" ,python)
                    ("openssl" ,openssl)
                    ("libsolv" ,libsolv)
                    ("libexpected" ,libexpected)
                    ("reproc-cpp" ,reproc-cpp)
                    ("zstd-cmake" ,zstd-cmake)
                    ))

   (synopsis "The Fast Cross-Platform Package Manager")
   (description "mamba is a reimplementation of the conda package manager in C++.")
   (home-page "https://github.com/mamba-org/mamba")
   (license license:expat)))
