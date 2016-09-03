(in-package :cl-user)
(defpackage stagger
  (:use :cl :restas))
(in-package :stagger)


(defun symbol-from (s)
  (if s
      (intern s)
      (gensym)))
   
(defmacro restas-endpoint (uri &rest args &body body)
  `(restas:define-route (`,(symbol-from uri) uri ,@args)
       ,@body))

#| 

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
