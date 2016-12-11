(in-package :stagger/test)

(plan 3)

(dolist (model
          (list (asdf/system:system-relative-pathname
                 :stagger "model/simple-rest.yaml")))
  (diag (format nil "Parsing ~A" model))
  (ok (stagger:parse-yaml model)))

(let ((annotations '(:args ((animal :source :parameter)))))
  (let ((result (getf annotations :args)))
    (is (stagger:set-property-list-form 'foo annotations)
        `(progn (setf (get 'foo :args) ',result)))))
(in-package :stagger/test)


(let ((annotations '(:args ((animal :source :parameter)
                            (use-mocks-p :source :parameters :type :string)))))
  (is stagger:let-args
      t))


(finalize)
