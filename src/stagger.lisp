(in-package :stagger)

(defun symbol-from (s)
  (if s
      (intern s)
      (gensym)))

(defun wash-args (args)
  (let ((removed-args nil)
        (new-args nil)
        (push-next-p nil))
    (dolist (arg args)
      (cond
        (push-next-p
         (push arg removed-args)
         (setf push-next-p nil))
        ((find arg '(:args :result :doc))
          (push arg removed-args)
          (setf push-next-p t))
        (t
         (push arg new-args))))
  (values new-args removed-args)))
      
(defmacro restas-endpoint (uri &rest args)
  `(list ,uri ,(string (symbol-from uri))  ,@args))


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

(defun parse (pathname)
  (let ((p (if (pathnamep pathname)
                pathname
                (pathname pathname))))
    (cl-yaml:parse p)))

