#|
  This file is a part of stagger project.
  Copyright (c) 2016 Mark (<evenson.not.org@gmail.com>)
|#

(in-package :cl-user)
(defpackage stagger-test-asd
  (:use :cl :asdf))
(in-package :stagger-test-asd)

(defsystem stagger-test
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
