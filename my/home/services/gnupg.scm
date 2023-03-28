
(define-module (my home services gnupg)
  #:use-module (gnu)
  #:use-module (guix)
  #:use-module (gnu services)
  #:use-module (gnu services shepherd)
  #:use-module (gnu home services)
  #:use-module (gnu home services shepherd)
  #:use-module (gnu packages gnupg)
  #:export (home-gnupg-service-type))

(define (home-gnupg-service _)
  (list (shepherd-service
                     (documentation "User GPG-Agent Daemon")
                     (provision '(gpg-agent))
                     (requirement '())
                     (start #~(make-system-constructor
                                #$(file-append gnupg "/bin/gpg-agent")
                                " --daemon"))
                     (stop #~(make-system-destructor
                               #$(file-append gnupg "/bin/gpg-connect-agent")
                               "killagent /bye")))))

(define home-gnupg-service-type
  (service-type
   (name 'gpg-agent)
   (extensions
    (list (service-extension home-shepherd-service-type home-gnupg-service)))
   (default-value #f)
   (description "run gpg-agent")))
