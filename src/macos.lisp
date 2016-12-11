(in-package :stagger)
;;; Necessary for finding CL-LIBYAML under MacPorts
(defun macos/patch-cffi-macports ()
  "Add appropiate directories for framework install local libararies
under macOS."
  ;; Automagically load Quicklisp from ABCL
  #+abcl (progn
           (require :abcl-contrib)
           (require :quicklisp-abcl))
  ;; Patch loading of CFFI for MacPorts
  (require :asdf)
  (asdf:load-system :cffi)
  (setf cffi:*foreign-library-directories*
        (push #p"/opt/local/lib/"
              cffi:*foreign-library-directories*)))


