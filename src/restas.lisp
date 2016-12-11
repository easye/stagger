(in-package :stagger)

#| 
Targeted USAGE
(restas-endpoint ("relative/path"
                  :method :post
                  :args ((arg1 :source :query 
                               :type :string)
                         (arg2 :source :parameters 
                               :type :string))
                  :content-type "mime/type ;; or ("application/pdf" "other-mime/type")
                  :result schema)
   IMPLEMENTATION
|#

(defmacro endpoint (symbol (uri &rest args) &body body)
  "Create a RESTAS:DEFINE-ROUTE definition for an api endpoint.

The value of SYMBOL names the function that invokes BODY with the appropiate
parameters.

URI is a pattern matching the route.  

ARGS can contain either any allowable keyword parameter allowed by
RESTAS:DEFINE-ROUTE or one of the following annotation forms:

:ARGS contains a list of argument descriptors. An argument descriptor is a list of the form
(NAME :source SOURCE :type TYPE) where NAME

:RETURNS describes the return parameters allowed by this route.

:DOC contains additional documentation.

"
  (multiple-value-bind (restas-args annotations)
      (wash-args args)
    `(progn
        (restas:define-route ,symbol (,uri ,@restas-args)
           ,(let-args annotations)
           ,@body)
        (eval-when (:compile-toplevel :load-toplevel :execute)
             (setf (get ',symbol :relative-uri) ,uri)
            ,(stagger:set-property-list-form symbol annotations)))))

(defun let-args (annotations)
  (anaphora:awhen (find :args annotations)
    (quote it)))

;;; (UNUSED) A version of the endpoint macro which contructs a symbol
;;; from the URI for binding to the route
#+nil
(defmacro endpoint/synthetic-symbol ((uri &rest args) &body body)
  (let ((symbol (symbol-from uri)))
    (endpoint symbol `(uri ,@args) body)))

