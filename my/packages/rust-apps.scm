(define-module (my packages rust-apps)
  #:use-module (gnu packages crates-graphics)
  #:use-module (gnu packages crates-io)
  #:use-module (guix build-system cargo)
  #:use-module (guix build-system cargo)
  #:use-module (guix download)
  #:use-module (guix packages)
  #:use-module ((guix licenses) #:prefix license:))

(define-public rust-temptree-0.2
  (package
    (name "rust-temptree")
    (version "0.2.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "temptree" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0c461j4xrjp1mz89fb3rmv8w36m1dm1nymv9ny60hh0v4pc99nlg"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-tempfile" ,rust-tempfile-3))))
    (home-page "https://github.com/casey/temptree")
    (synopsis "Temporary trees of files")
    (description "Temporary trees of files")
    (license license:cc0)))

(define-public rust-nix-0.22
  (package
    (name "rust-nix")
    (version "0.22.3")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "nix" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1bsgc8vjq07a1wg9vz819bva3dvn58an4r87h80dxrfqkqanz4g4"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-bitflags" ,rust-bitflags-1)
                       ("rust-cc" ,rust-cc-1)
                       ("rust-cfg-if" ,rust-cfg-if-1)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-memoffset" ,rust-memoffset-0.6))))
    (home-page "https://github.com/nix-rust/nix")
    (synopsis "Rust friendly bindings to *nix APIs")
    (description "Rust friendly bindings to *nix APIs")
    (license license:expat)))

(define-public rust-executable-path-1
  (package
    (name "rust-executable-path")
    (version "1.0.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "executable-path" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0y0lhhrx9f9q1f81am3b20f8znixjcvqfg7kx220pjg3i5nmmg1y"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t))
    (home-page "https://github.com/casey/rust-executable-path")
    (synopsis "Get the path of a binary target's executable")
    (description "Get the path of a binary target's executable")
    (license license:cc0)))

(define-public rust-cradle-0.2
  (package
    (name "rust-cradle")
    (version "0.2.2")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "cradle" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "16n04y60jps91dsw5fs6p8zash052y82aclg57kkvm9320n155kh"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-executable-path" ,rust-executable-path-1)
                       ("rust-gag" ,rust-gag-0.1)
                       ("rust-nix" ,rust-nix-0.22)
                       ("rust-rustversion" ,rust-rustversion-1))))
    (home-page "https://github.com/soenkehahn/cradle")
    (synopsis "Execute child processes with ease")
    (description "Execute child processes with ease")
    (license license:cc0)))

(define-public rust-uuid-macro-internal-1
  (package
    (name "rust-uuid-macro-internal")
    (version "1.3.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "uuid-macro-internal" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1jbccm5pk216zrrf0ibd1j7m86lgmsyibs8d59ykhak5g2l01cy1"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-proc-macro2" ,rust-proc-macro2-1)
                       ("rust-quote" ,rust-quote-1)
                       ("rust-syn" ,rust-syn-1))))
    (home-page "")
    (synopsis "Private implementation details of the uuid! macro.")
    (description "Private implementation details of the uuid! macro.")
    (license (list license:asl2.0 license:expat))))

(define-public rust-derive-arbitrary-1
  (package
    (name "rust-derive-arbitrary")
    (version "1.2.3")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "derive_arbitrary" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "005x40g2k89g31lx4dzi4biw76s42b5cvpmvk209w8if3rqf9vlb"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-proc-macro2" ,rust-proc-macro2-1)
                       ("rust-quote" ,rust-quote-1)
                       ("rust-syn" ,rust-syn-1))))
    (home-page "https://github.com/rust-fuzz/arbitrary")
    (synopsis "Derives arbitrary traits")
    (description "Derives arbitrary traits")
    (license (list license:expat license:asl2.0))))

(define-public rust-arbitrary-1
  (package
    (name "rust-arbitrary")
    (version "1.2.3")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "arbitrary" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1bdd7s3jvj02mkhy5pcfymab47jhi3zxl29dxy9v59sswr6sz41y"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-derive-arbitrary" ,rust-derive-arbitrary-1))))
    (home-page "https://github.com/rust-fuzz/arbitrary/")
    (synopsis
     "The trait for generating structured data from unstructured data")
    (description
     "The trait for generating structured data from unstructured data")
    (license (list license:expat license:asl2.0))))

(define-public rust-uuid-1
  (package
    (name "rust-uuid")
    (version "1.3.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "uuid" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0ygxkj6bgfjkbhpdj1s0607zi9l8886pcw04lryd647f4r9q8x0n"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-arbitrary" ,rust-arbitrary-1)
                       ("rust-atomic" ,rust-atomic-0.5)
                       ("rust-getrandom" ,rust-getrandom-0.2)
                       ("rust-md-5" ,rust-md-5-0.10)
                       ("rust-rand" ,rust-rand-0.8)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-sha1-smol" ,rust-sha1-smol-1)
                       ("rust-slog" ,rust-slog-2)
                       ("rust-uuid-macro-internal" ,rust-uuid-macro-internal-1)
                       ("rust-wasm-bindgen" ,rust-wasm-bindgen-0.2)
                       ("rust-zerocopy" ,rust-zerocopy-0.6))))
    (home-page "https://github.com/uuid-rs/uuid")
    (synopsis "A library to generate and parse UUIDs.")
    (description
     "This package provides a library to generate and parse UUIDs.")
    (license (list license:asl2.0 license:expat))))

(define-public rust-target-2
  (package
    (name "rust-target")
    (version "2.0.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "target" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0p5hi5vxcs8w95qmg9hsv985g8kaxjrzjlgsybmf4h13a1qjx1ds"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t))
    (home-page "https://github.com/casey/target")
    (synopsis "Get information on compilation target")
    (description "Get information on compilation target")
    (license license:cc0)))

(define-public rust-strum-macros-0.24
  (package
    (name "rust-strum-macros")
    (version "0.24.3")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "strum_macros" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0naxz2y38kwq5wgirmia64vvf6qhwy8j367rw966n62gsbh5nf0y"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-heck" ,rust-heck-0.4)
                       ("rust-proc-macro2" ,rust-proc-macro2-1)
                       ("rust-quote" ,rust-quote-1)
                       ("rust-rustversion" ,rust-rustversion-1)
                       ("rust-syn" ,rust-syn-1))))
    (home-page "https://github.com/Peternator7/strum")
    (synopsis "Helpful macros for working with enums and strings")
    (description "Helpful macros for working with enums and strings")
    (license license:expat)))

(define-public rust-strum-0.24
  (package
    (name "rust-strum")
    (version "0.24.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "strum" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0gz6cjhlps5idwasznklxdh2zsas6mxf99vr0n27j876q12n0gh6"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-phf" ,rust-phf-0.10)
                       ("rust-strum-macros" ,rust-strum-macros-0.24))))
    (home-page "https://github.com/Peternator7/strum")
    (synopsis "Helpful macros for working with enums and strings")
    (description "Helpful macros for working with enums and strings")
    (license license:expat)))

(define-public rust-snafu-derive-0.7
  (package
    (name "rust-snafu-derive")
    (version "0.7.4")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "snafu-derive" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1cl1vyxkwb0nbp223ryfxkzrzsrh3xydcqkgi8nnzhj5aaz3nns7"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-heck" ,rust-heck-0.4)
                       ("rust-proc-macro2" ,rust-proc-macro2-1)
                       ("rust-quote" ,rust-quote-1)
                       ("rust-syn" ,rust-syn-1))))
    (home-page "https://github.com/shepmaster/snafu")
    (synopsis "An ergonomic error handling library")
    (description "An ergonomic error handling library")
    (license (list license:expat license:asl2.0))))

(define-public rust-snafu-0.7
  (package
    (name "rust-snafu")
    (version "0.7.4")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "snafu" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0iahih8w3wwh4mj839wxcwyalx5v69isihmk75n0zdzzwgkmc1nb"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-backtrace" ,rust-backtrace-0.3)
                       ("rust-doc-comment" ,rust-doc-comment-0.3)
                       ("rust-futures" ,rust-futures-0.3)
                       ("rust-futures-core" ,rust-futures-core-0.3)
                       ("rust-pin-project" ,rust-pin-project-1)
                       ("rust-snafu-derive" ,rust-snafu-derive-0.7))))
    (home-page "https://github.com/shepmaster/snafu")
    (synopsis "An ergonomic error handling library")
    (description "An ergonomic error handling library")
    (license (list license:expat license:asl2.0))))

(define-public rust-lexiclean-0.0.1
  (package
    (name "rust-lexiclean")
    (version "0.0.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "lexiclean" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1rb8sky7gi75a7xxn6xrfkrbqkp465npm54p5s89ysqhgc0ja4j4"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t))
    (home-page "https://github.com/casey/lexiclean")
    (synopsis "Lexically clean paths")
    (description "Lexically clean paths")
    (license license:cc0)))

(define-public rust-linux-raw-sys-0.1
  (package
    (name "rust-linux-raw-sys")
    (version "0.1.4")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "linux-raw-sys" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1926520si5wkn4m6iz6ka97ya5q1dgr8ib3fd705fscfgixgflgh"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-compiler-builtins" ,rust-compiler-builtins-0.1)
                       ("rust-rustc-std-workspace-core" ,rust-rustc-std-workspace-core-1))))
    (home-page "https://github.com/sunfishcode/linux-raw-sys")
    (synopsis "Generated bindings for Linux's userspace API")
    (description "Generated bindings for Linux's userspace API")
    (license (list license:asl2.0 license:asl2.0 license:expat))))

(define-public rust-rustix-0.36
  (package
    (name "rust-rustix")
    (version "0.36.9")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "rustix" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1g1pxwmz82gf47ar5l80ijzpbcrf5yh9a6bdfi05pmgc3zqnyp7x"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-bitflags" ,rust-bitflags-1)
                       ("rust-cc" ,rust-cc-1)
                       ("rust-compiler-builtins" ,rust-compiler-builtins-0.1)
                       ("rust-errno" ,rust-errno-0.2)
                       ("rust-io-lifetimes" ,rust-io-lifetimes-1)
                       ("rust-itoa" ,rust-itoa-1)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-linux-raw-sys" ,rust-linux-raw-sys-0.1)
                       ("rust-once-cell" ,rust-once-cell-1)
                       ("rust-rustc-std-workspace-alloc" ,rust-rustc-std-workspace-alloc-1)
                       ("rust-rustc-std-workspace-core" ,rust-rustc-std-workspace-core-1)
                       ("rust-windows-sys" ,rust-windows-sys-0.45))))
    (home-page "https://github.com/bytecodealliance/rustix")
    (synopsis "Safe Rust bindings to POSIX/Unix/Linux/Winsock2-like syscalls")
    (description
     "Safe Rust bindings to POSIX/Unix/Linux/Winsock2-like syscalls")
    (license (list license:asl2.0 license:asl2.0 license:expat))))

(define-public rust-windows-x86-64-msvc-0.42
  (package
    (name "rust-windows-x86-64-msvc")
    (version "0.42.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "windows_x86_64_msvc" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1zfgzsmc0j5p9yx25j15lb1yh45mazl4hhjdvfqqhcm16snn0xj4"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t))
    (home-page "https://github.com/microsoft/windows-rs")
    (synopsis "Code gen support for the windows crate")
    (description "Code gen support for the windows crate")
    (license (list license:expat license:asl2.0))))

(define-public rust-windows-x86-64-gnullvm-0.42
  (package
    (name "rust-windows-x86-64-gnullvm")
    (version "0.42.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "windows_x86_64_gnullvm" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0qq41m3zkakkmch9x4x30lgv0sy3zh4jpdpxch6jp8ns6brgv2v2"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t))
    (home-page "https://github.com/microsoft/windows-rs")
    (synopsis "Code gen support for the windows crate")
    (description "Code gen support for the windows crate")
    (license (list license:expat license:asl2.0))))

(define-public rust-windows-x86-64-gnu-0.42
  (package
    (name "rust-windows-x86-64-gnu")
    (version "0.42.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "windows_x86_64_gnu" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0icwd66wd6p9hhzds93333wy2knlqbyiynf2rfy7xqc528i0y161"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t))
    (home-page "https://github.com/microsoft/windows-rs")
    (synopsis "Code gen support for the windows crate")
    (description "Code gen support for the windows crate")
    (license (list license:expat license:asl2.0))))

(define-public rust-windows-i686-msvc-0.42
  (package
    (name "rust-windows-i686-msvc")
    (version "0.42.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "windows_i686_msvc" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "01966w2707qrw183lqg62i1as614i88m5a0s6pzxdpby64i12kdz"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t))
    (home-page "https://github.com/microsoft/windows-rs")
    (synopsis "Code gen support for the windows crate")
    (description "Code gen support for the windows crate")
    (license (list license:expat license:asl2.0))))

(define-public rust-windows-i686-gnu-0.42
  (package
    (name "rust-windows-i686-gnu")
    (version "0.42.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "windows_i686_gnu" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0h6n8mqjfq1rk4vpr9gz8md1b8f7bqksiymivdxvlc6mi998ff6y"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t))
    (home-page "https://github.com/microsoft/windows-rs")
    (synopsis "Code gen support for the windows crate")
    (description "Code gen support for the windows crate")
    (license (list license:expat license:asl2.0))))

(define-public rust-windows-aarch64-msvc-0.42
  (package
    (name "rust-windows-aarch64-msvc")
    (version "0.42.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "windows_aarch64_msvc" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1iy6adiaz2956f0kcl2wfdjx49ayv2lp11glkxxc85pw7xkip2sc"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t))
    (home-page "https://github.com/microsoft/windows-rs")
    (synopsis "Code gen support for the windows crate")
    (description "Code gen support for the windows crate")
    (license (list license:expat license:asl2.0))))

(define-public rust-windows-aarch64-gnullvm-0.42
  (package
    (name "rust-windows-aarch64-gnullvm")
    (version "0.42.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "windows_aarch64_gnullvm" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0256d14kqpiniwcm6y2yfj7jbzdvvj4l6i65r5zyrza36bl6964c"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t))
    (home-page "https://github.com/microsoft/windows-rs")
    (synopsis "Code gen support for the windows crate")
    (description "Code gen support for the windows crate")
    (license (list license:expat license:asl2.0))))

(define-public rust-windows-targets-0.42
  (package
    (name "rust-windows-targets")
    (version "0.42.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "windows-targets" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1rwh2d1yvfjvlfidi8p9ha4lp34lb0lynynlhk65ikdz3x4j49cf"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-windows-aarch64-gnullvm" ,rust-windows-aarch64-gnullvm-0.42)
                       ("rust-windows-aarch64-msvc" ,rust-windows-aarch64-msvc-0.42)
                       ("rust-windows-i686-gnu" ,rust-windows-i686-gnu-0.42)
                       ("rust-windows-i686-msvc" ,rust-windows-i686-msvc-0.42)
                       ("rust-windows-x86-64-gnu" ,rust-windows-x86-64-gnu-0.42)
                       ("rust-windows-x86-64-gnullvm" ,rust-windows-x86-64-gnullvm-0.42)
                       ("rust-windows-x86-64-msvc" ,rust-windows-x86-64-msvc-0.42))))
    (home-page "https://github.com/microsoft/windows-rs")
    (synopsis "Code gen support for the windows crate")
    (description "Code gen support for the windows crate")
    (license (list license:expat license:asl2.0))))

(define-public rust-windows-sys-0.45
  (package
    (name "rust-windows-sys")
    (version "0.45.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "windows-sys" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1l36bcqm4g89pknfp8r9rl1w4bn017q6a8qlx8viv0xjxzjkna3m"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-windows-targets" ,rust-windows-targets-0.42))))
    (home-page "https://github.com/microsoft/windows-rs")
    (synopsis "Rust for Windows")
    (description "Rust for Windows")
    (license (list license:expat license:asl2.0))))

(define-public rust-io-lifetimes-1
  (package
    (name "rust-io-lifetimes")
    (version "1.0.5")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "io-lifetimes" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1cqg2zy012r0l3l772mjh45m11jm0ybw7bgqgwk8308gvnhbgghs"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-async-std" ,rust-async-std-1)
                       ("rust-fs-err" ,rust-fs-err-2)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-mio" ,rust-mio-0.8)
                       ("rust-os-pipe" ,rust-os-pipe-1)
                       ("rust-socket2" ,rust-socket2-0.4)
                       ("rust-tokio" ,rust-tokio-1)
                       ("rust-windows-sys" ,rust-windows-sys-0.45))))
    (home-page "https://github.com/sunfishcode/io-lifetimes")
    (synopsis "A low-level I/O ownership and borrowing library")
    (description
     "This package provides a low-level I/O ownership and borrowing library")
    (license (list license:asl2.0 license:asl2.0 license:expat))))

(define-public rust-hermit-abi-0.3
  (package
    (name "rust-hermit-abi")
    (version "0.3.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "hermit-abi" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "11j2v3q58kmi5mhjvh6hfrb7il2yzg7gmdf5lpwnwwv6qj04im7y"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-compiler-builtins" ,rust-compiler-builtins-0.1)
                       ("rust-rustc-std-workspace-alloc" ,rust-rustc-std-workspace-alloc-1)
                       ("rust-rustc-std-workspace-core" ,rust-rustc-std-workspace-core-1))))
    (home-page "https://github.com/hermitcore/rusty-hermit")
    (synopsis "Hermit system calls definitions.")
    (description "Hermit system calls definitions.")
    (license (list license:expat license:asl2.0))))

(define-public rust-is-terminal-0.4
  (package
    (name "rust-is-terminal")
    (version "0.4.4")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "is-terminal" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0mqqjb9z59gdbm280yq1h46h8xk40952x58fp5lqwfj1fqjv7di1"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-hermit-abi" ,rust-hermit-abi-0.3)
                       ("rust-io-lifetimes" ,rust-io-lifetimes-1)
                       ("rust-rustix" ,rust-rustix-0.36)
                       ("rust-windows-sys" ,rust-windows-sys-0.45))))
    (home-page "https://github.com/sunfishcode/is-terminal")
    (synopsis "Test whether a given stream is a terminal")
    (description "Test whether a given stream is a terminal")
    (license license:expat)))

(define-public rust-env-logger-0.10
  (package
    (name "rust-env-logger")
    (version "0.10.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "env_logger" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1w797qgkrmqdacsbc0j6yvpnmvfc9lx6k8fm79rndkxci5mapkc5"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-humantime" ,rust-humantime-2)
                       ("rust-is-terminal" ,rust-is-terminal-0.4)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-regex" ,rust-regex-1)
                       ("rust-termcolor" ,rust-termcolor-1))))
    (home-page "https://github.com/rust-cli/env_logger/")
    (synopsis
     "A logging implementation for `log` which is configured via an environment
variable.
")
    (description
     "This package provides a logging implementation for `log` which is configured via
an environment variable.")
    (license (list license:expat license:asl2.0))))

(define-public rust-dotenvy-0.15
  (package
    (name "rust-dotenvy")
    (version "0.15.6")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "dotenvy" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "182cwm14w6asklr0fdzrkzvkfz7bylaxir9p1hp3djx8swbw9n03"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-clap" ,rust-clap-3))))
    (home-page "https://github.com/allan2/dotenvy")
    (synopsis "A well-maintained fork of the dotenv crate")
    (description
     "This package provides a well-maintained fork of the dotenv crate")
    (license license:expat)))

(define-public rust-just-1
  (package
    (name "rust-just")
    (version "1.13.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "just" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0ci72kqrkgayn57myynjlzb21pgsbfix32nip6kl236sab1bb20r"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-ansi-term" ,rust-ansi-term-0.12)
                       ("rust-atty" ,rust-atty-0.2)
                       ("rust-camino" ,rust-camino-1)
                       ("rust-clap" ,rust-clap-2)
                       ("rust-ctrlc" ,rust-ctrlc-3)
                       ("rust-derivative" ,rust-derivative-2)
                       ("rust-dotenvy" ,rust-dotenvy-0.15)
                       ("rust-edit-distance" ,rust-edit-distance-2)
                       ("rust-env-logger" ,rust-env-logger-0.10)
                       ("rust-heck" ,rust-heck-0.4)
                       ("rust-lexiclean" ,rust-lexiclean-0.0.1)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-regex" ,rust-regex-1)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-serde-json" ,rust-serde-json-1)
                       ("rust-sha2" ,rust-sha2-0.10)
                       ("rust-similar" ,rust-similar-2)
                       ("rust-snafu" ,rust-snafu-0.7)
                       ("rust-strum" ,rust-strum-0.24)
                       ("rust-target" ,rust-target-2)
                       ("rust-tempfile" ,rust-tempfile-3)
                       ("rust-typed-arena" ,rust-typed-arena-2)
                       ("rust-unicode-width" ,rust-unicode-width-0.1)
                       ("rust-uuid" ,rust-uuid-1))
       #:cargo-development-inputs (("rust-cradle" ,rust-cradle-0.2)
                                   ("rust-executable-path" ,rust-executable-path-1)
                                   ("rust-pretty-assertions" ,rust-pretty-assertions-1)
                                   ("rust-temptree" ,rust-temptree-0.2)
                                   ("rust-which" ,rust-which-4)
                                   ("rust-yaml-rust" ,rust-yaml-rust-0.4))))
    (home-page "https://github.com/casey/just")
    (synopsis "Just a command runner")
    (description "Just a command runner")
    (license license:cc0)))
