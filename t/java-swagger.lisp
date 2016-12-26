;; This one depends on Mineblimp

(in-package :stagger/test)


(let ((output-directory (namestring (ensure-directories-exist
                                     (asdf/system:system-relative-pathname :stagger "var/"))))
      (input-file (namestring (asdf:system-relative-pathname
                               :stagger "model/mineblimp-0.2.0.yaml")))
      (swagger-script (asdf/system:system-relative-pathname :stagger "src/bash/swagger.bash")))
  (dolist (lang (list "swagger" "go-server" "html" "java"))
    (diag (format nil "Outputing '~A' OpenAPI artifacts to '~A'" lang output-directory))
    (plan 1)
    (is (uiop/run-program:run-program
         `(,swagger-script
           "generate"
           "-i" ,input-file
           "-l" ,lang
           "-o" ,output-directory)
         :output t)
        nil)))

(finalize)

