(defpackage stagger/test
  (:use :cl
        :stagger
        :prove))

(in-package :stagger/test)


(plan 2)

(dolist (model (list (asdf/system:system-relative-pathname :stagger "model/simple-rest.yaml")))
  (diag (format nil "Parsing ~A" model))
  (ok (stagger:parse-yaml model)))

;; refactor test into stagger, as this one depends on Mineblimp
(let ((output-directory (namestring (ensure-directories-exist
                                     (asdf/system:system-relative-pathname :stagger "var/")))))
  (dolist (lang (list "swagger" "go-server" "html" "java"))
    (diag (format nil "Outputing '~A' OpenAPI artifacts to '~A'" lang output-directory))
    (ok (uiop/run-program:run-program
         `(,(asdf/system:system-relative-pathname :minebox "src/rest/swagger.bash")
            "generate"
            "-i" ,(namestring (asdf:system-relative-pathname
                               :minebox "src/lisp/routes/0.2.0/mineblimp-0.2.0.yaml"))
            "-l" ,lang
            "-o" ,output-directory)
       :output t))))


(finalize)
