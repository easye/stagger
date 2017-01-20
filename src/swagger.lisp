(in-package :stagger)

(defun swagger-model (path &key (output-directory #p"/var/tmp"))
  (#"main" 'io.swagger.codegen.SwaggerCodegen
           (java:jnew-array-from-list "java.lang.String"
                                      `("generate"
                                        "-i" ,(namestring path)
                                        "-l" "io.swagger.codegen.languages.SwaggerGenerator"
                                        "-o" ,(namestring output-directory)))))

(defun swagger/help ()
  (#"main" 'io.swagger.codegen.SwaggerCodegen
           (java:jnew-array-from-list "java.lang.String"
                                      '("help"))))

(defun swagger/languages ()
  (#"main" 'io.swagger.codegen.SwaggerCodegen
           (java:jnew-array-from-list "java.lang.String"
                                      '("langs"))))


(export '(swagger-model swagger/help swagger/languages)
        :stagger)
