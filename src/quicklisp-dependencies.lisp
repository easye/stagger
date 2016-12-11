;;; <https://beta.quicklisp.org/quicklisp.lisp>
#-quicklisp
(let ((quicklisp-init (merge-pathnames "quicklisp/setup.lisp"
                                       (user-homedir-pathname))))
  (when (probe-file quicklisp-init)
    (load quicklisp-init)))

(dolist (system '(:restas
                  :cl-yaml :libyaml
                  :prove))
  (unless (asdf:find-system system)
    (ql:quickload system)))

