(in-package :stagger)

(defparameter *open-api-keywords* '(:security
                                    :args :parameters
                                    :responses
                                    :doc :summary :description :external-docs 
                                    :produces
                                    :consumes
                                    :deprecated
                                    :schemes ;; probably should be separated out
                                    :operation-id))

(defun wash-args (args)
  "Washes the plist ARGS into two values.  The first value contains
all properties not in the *OPEN-API-KEYWORDS* special."
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

(defun parse-yaml (pathname)
  (let ((p (if (pathnamep pathname)
                pathname
                (pathname pathname))))
    (cl-yaml:parse p)))

(defun symbol-from (s)
  (if s
      (intern (format nil "%~A" (string-upcase s)))
      (gensym)))

(defun api-symbols (package)
  (loop :for symbol :being :each :present-symbol :in (find-package package)
     :when (search "%" (symbol-name symbol))
     :collect symbol))

(defun introspect-paths (package)
  (loop :for symbol :in (api-symbols package)
     :collecting (get symbol :url)))

(defun set-property-list-form (symbol annotations)
  (let ((setters
         (loop :for keyword :in *open-api-keywords*
            :when (getf annotations keyword)
            :collect `(setf (get ',symbol ,keyword)
                            ',(getf annotations keyword)))))
    `(progn ,@setters)))


