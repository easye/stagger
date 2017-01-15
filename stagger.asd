#|
  This file is a part of the stagger project.
  Copyright (c) 2016 Mark (<evenson.not.org@gmail.com>)
|#

#-quicklisp 
#+abcl
(eval-when (:load-toplevel :execute)
  (asdf:load-system :quicklisp-abcl))
(in-package :cl-user)
(require :asdf)

(asdf:defsystem stagger
  :description
  "Tools for extracting, manipulating and transpiling OpenAPI specifications."
  :version "0.3.0" :author "e@not.org" :license "BSD"
  :depends-on (anaphora ;; TODO move onerous dependencies into sub systems
               simple-date-time
               cl-yaml
               restas
               parenscript)
  :components ((:module "package"
                        :pathname "src/"
                        :components ((:file "package")))
               (:module "runtime"
                        :pathname "src/"
                        :components ((:file "macos")))
               (:module "src"
                        :depends-on (package)
                        :components ((:file "stagger")
                                     (:file "restas" :depends-on (stagger))))
               (:module "example"
                        :pathname "src/"
                        :components ((:file "example"))))
  :in-order-to ((asdf:test-op (asdf:test-op stagger/test))))

#+abcl
(asdf:defsystem stagger/java
                :depends-on (stagger jss)
                :defsystem-depends-on (abcl-asdf)
                :components ((:mvn "io.swagger/swagger-codegen-cli/2.2.1")
                             (:module source
                                      :pathname "src/"
                                      :components ((:file "swagger")))))

(asdf:defsystem stagger/test
  :author "Mark" :license "BSD"
  :defsystem-depends-on (prove-asdf)
  :depends-on (stagger
               prove)
  :components ((:module package
                        :pathname "t/"
                        :components ((:file "package")))
               (:module source
                        :pathname "t/"
                        :depends-on (package)
                        :components ((:test-file "java-swagger")
                                     (:test-file "api")
                                     (:test-file "staggering"))))
  :description "Test system for stagger"
  :perform (asdf:test-op :after (op c)
                         (uiop:symbol-call :prove-asdf 'run-test-system c)))


