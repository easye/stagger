(defpackage stagger/test
  (:use :cl
        :stagger
        :prove))

(in-package :stagger/test)


(plan 1)

(dolist (model (list (asdf/system:system-relative-pathname :stagger "model/simple-rest.yaml")))
  (diag (format nil "Parsing ~A" model))
  (ok (stagger:parse model)))

(finalize)
