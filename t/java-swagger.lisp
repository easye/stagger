;; This one depends on Mineblimp

(in-package :stagger/test)

(when (asdf:load-system :minebox)
  (plan 1)
  (let ((output-directory (namestring (ensure-directories-exist
                                       (asdf/system:system-relative-pathname :stagger "var/")))))
    (dolist (lang (list "swagger" "go-server" "html" "java"))
      (diag (format nil "Outputing '~A' OpenAPI artifacts to '~A'" lang output-directory))
      (is (uiop/run-program:run-program
           `(,(asdf/system:system-relative-pathname :minebox "src/rest/swagger.bash")
              "generate"
              "-i" ,(namestring (asdf:system-relative-pathname
                                 :minebox "src/lisp/routes/0.2.0/mineblimp-0.2.0.yaml"))
              "-l" ,lang
              "-o" ,output-directory)
           :output t)
          nil))))

(finalize)

