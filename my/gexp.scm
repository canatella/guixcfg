(define-module (my gexp)
  #:use-module (guix gexp)
  #:export (read-file-like))

(define* (read-file-like file #:key (encoding "UTF-8"))
  "Returns a gexp, which reads all the content of the FILE and returns it as a
string.  FILE must be a file-like object."
  (when (not (file-like? file))
    (raise (formatted-message
            (G_ "~a is not a file-like object.")
            file)))
  #~(call-with-input-file #$file
      (@ (ice-9 textual-ports) get-string-all)
      #:encoding #$encoding))
