(in-package :stagger/test)


(plan 2)

(dolist (model (list (asdf/system:system-relative-pathname :stagger "model/simple-rest.yaml")))
  (diag (format nil "Parsing ~A" model))
  (ok (stagger:parse-yaml model)))

(plan 1)

(let ((annotations '(:args ((animal :source :parameter)))))
  (let ((result (getf annotations :args)))
    (is (stagger:set-property-list-form 'foo annotations)
        `(progn (setf (get 'foo :args) ',result)))))

(finalize)
