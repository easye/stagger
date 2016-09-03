#|
  This file is a part of stagger project.
  Copyright (c) 2016 Mark (<evenson.not.org@gmail.com>)
|#

#-quicklisp 
#+abcl
(eval-when (:load-toplevel :execute)
  (asdf:load-system :quicklisp-abcl))
;;#-abcl
;;(eval-when (:load-toplevel :execute)
;;  (load #p"~/quicklisp/setup.lisp")

(in-package :cl-user)
(defpackage stagger-asd
  (:use :cl :asdf))
(in-package :stagger-asd)

(defsystem stagger
  :version "0.1.0"
  :author "Mark"
  :license ""
  :depends-on ()
  :components ((:module "src"
                :components
                ((:file "stagger"))))
  :description ""
  :in-order-to ((test-op (test-op stagger/test))))

(defsystem stagger/test
  :author "Mark"
  :license ""
  :depends-on (:stagger
               :prove)
  :components ((:module "t"
                :components
                ((:test-file "stagger"))))
  :description "Test system for stagger"

  :defsystem-depends-on (:prove-asdf)
  :perform (test-op :after (op c)
                    (funcall (intern #.(string :run-test-system) :prove-asdf) c)
                    (asdf:clear-system c)))
