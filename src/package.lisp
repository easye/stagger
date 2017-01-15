(defpackage stagger
  (:nicknames #:bitbucket.org/easye/stagger)
  (:use #:cl)
  (:export

   ;;; Declare REST endpoints API for stagger
   #:endpoint

   ;; API for macrology for endpoint construction
   #:set-property-list-form
   #:let-args

   ;; wrapping cl-yaml
   #:parse-yaml))







