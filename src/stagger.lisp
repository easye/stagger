(in-package :stagger)

(defun symbol-from (s)
  (if s
      (intern (format nil "%~A" (string-upcase s)))
      (gensym)))

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

(defvar *open-api-keywords* '(:args :result :doc))

(defun wash-args (args)
  (let ((removed-args nil)
        (new-args nil)
        (push-next-p nil))
    (dolist (arg args)
      (cond
        (push-next-p
         (push arg removed-args)
         (setf push-next-p nil))
        ((find arg *open-api-keywords*)
          (push arg removed-args)
          (setf push-next-p t))
        (t
         (push arg new-args))))
    (values (reverse new-args)
            (reverse removed-args))))

(defmacro restas-endpoint ((uri &rest args) body)
  (multiple-value-bind (restas-args other)
      (wash-args args)
    (let ((symbol (symbol-from uri)))
      `(progn
         (restas:define-route ,symbol (,uri ,@restas-args)
           ,@body)
         ,(loop :for keyword :in *open-api-keywords*
             :when (getf other keyword)
             :collect `(setf (get ,symbol ,keyword)
                             (getf ,other ,keyword)))))))

(defun parse-yaml (pathname)
  (let ((p (if (pathnamep pathname)
                pathname
                (pathname pathname))))
    (cl-yaml:parse p)))

