(define-module (my keyboard-layout)
  #:use-module (gnu system keyboard)
  #:export (%my-keyboard-layout))

(define %my-keyboard-layout (keyboard-layout "fr" "bepo" #:model "pc105"))
