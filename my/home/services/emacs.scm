(define-module (my home services emacs)
  #:use-module (gnu home services)
  #:use-module (gnu home services shepherd)
  #:use-module (gnu packages emacs)
  #:use-module (guix gexp)
  #:export (home-emacs-service-type))

(define (home-emacs-service _)
  (list
   (shepherd-service
    (provision '(emacs-daemon))
    (start #~(make-forkexec-constructor
	      (list #$(file-append (@@ (gnu packages glib ) dbus) "/bin/dbus-run-session")
		    #$(file-append (@@ (gnu packages emacs) emacs-next) "/bin/emacs")
		    "--fg-daemon")
	      #:log-file (string-append
			  (or (getenv "XDG_LOG_HOME")
			      (format #f "~a/.local/var/log"
				      (getenv "HOME")))
			  "/emacs-service.log")))
    (stop  #~(make-kill-destructor)))))

(define home-emacs-service-type
  (service-type
   (name 'emacs-daemon)
   (extensions
    (list (service-extension
	   home-shepherd-service-type
	   home-emacs-service)))
   (default-value #f)
   (description "run emacs in daemon mode")))
