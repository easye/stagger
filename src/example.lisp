(restas:define-module #:route.example/0/0/1 
  (:nicknames #:route.example/0/0
              #:route.example/0)
  (:use #:cl))

(in-package #:route.example/0)

(stagger:endpoint %weather ("weather"
                            :doc "Retrieve current weather."
                            :content-type "text/plain")
  "Nice weather today")

(stagger:endpoint %farm ("animal"
                         :doc
                         "Retrieve ANIMAL for FARMER."

                         :args
                         ((animal :source :parameter)
                          (farmer :source :query))

                         :responses
                         ((200 (:parenscript
                                (ps:create type "animal"
                                           data "{0}")))
                          (304 (:uri "/barn/{id}"))
                          (400 (:content-type "text/plain")))

                         :content-type
                         "text/plain")
  (format nil "Old MacDonald has a ~a on his farm." animal))

;;; FIXME: This bombs the stack: a mount probably has to be made with
;;; reference to a RESTAS acceptor
#+nil
(restas:mount-module -farm- (#:route.example/0/0/1)
  (:url "/farm"))
                 
