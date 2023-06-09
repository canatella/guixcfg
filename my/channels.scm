(define-module (my channels)
  #:use-module (guix channels))

(list (channel
        (name 'guix)
        (url "/home/dam/dm/guix")
        (branch "master")
        (commit
          "c4cca9cb5d3e93ef146acb930a95da9d2da6fb06")
        (introduction
          (make-channel-introduction
            "9edb3f66fd807b096b48283debdcddccfea34bad"
            (openpgp-fingerprint
              "BBB0 2DDF 2CEA F6A8 0D1D  E643 A2A0 6DF2 A33A 54FA"))))
      (channel
        (name 'nonguix)
        (url "https://gitlab.com/nonguix/nonguix")
        (branch "master")
        (commit
          "ceeeb5365de0106919857fbf1cead741b0735cfe")
        (introduction
          (make-channel-introduction
            "897c1a470da759236cc11798f4e0a5f7d4d59fbc"
            (openpgp-fingerprint
              "2A39 3FFF 68F4 EF7A 3D29  12AF 6F51 20A0 22FB B2D5")))))
