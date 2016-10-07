#|
  This file is a part of the stagger project.
  Copyright (c) 2016 Mark (<evenson.not.org@gmail.com>)
|#

#-quicklisp 
#+abcl
(eval-when (:load-toplevel :execute)
  (asdf:load-system :quicklisp-abcl))
;;#-abcl
;;(eval-when (:load-toplevel :execute)
;;  (load #p"~/quicklisp/setup.lisp")

(require :asdf)
(in-package :asdf)

(defsystem stagger
  :version "0.1.0"
  :author "Mark"
  :license "BSD"
  :depends-on (restas
               cl-yaml)
  :components ((:module "package"
                        :pathname "src/"
                        :components ((:file "package")))
               (:module "src"
                        :depends-on (package)
                        :components ((:file "stagger")
                                     (:file "restas" :depends-on (stagger))))
               (:module "example"
                        :pathname "src/"
                        :components ((:file "example"))))
  :description "Tools for extracting, manipulating and transpiling OpenAPI specifications."
  :in-order-to ((test-op (test-op stagger/test))))

(defsystem stagger/test
  :author "Mark"
  :license "BSD"
  :depends-on (stagger
               prove)
  :components ((:module "package"
                        :pathname "src/"
                        :components ((:file "package-test")))
               (:module "t"
                        :components ((:test-file "java-swagger")
                                     (:test-file "staggering"))))
  :description "Test system for stagger"
  :defsystem-depends-on (:prove-asdf)
  :perform (test-op :after (op c)
                    (funcall (intern #.(string :run-test-system) :prove-asdf) c)
                    (asdf:clear-system c)))

;;; I'm an evil runtime thingie: figure out how to eliminate me
(eval-when (:compile-toplevel :load-toplevel :execute)
  (let ((quicklisp-dependencies (asdf:system-relative-pathname :chute "quicklisp-setup.lisp")))
    (format t "~&Doing a QL:QUICKLOAD across all dependencies declared in <file:~a> ...~^"
            quicklisp-dependencies)

    (format t "~&DONE executing QL:QUICKLOAD forms from <file:~a>.~^"
            quicklisp-dependencies)))
