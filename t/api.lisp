(in-package :route.stagger.test/0/0/1)

(stagger:endpoint %farm ("farm"
                         :content-type "text/plain"
                         :args ((id :source :path))
                         :responses ((200 "string")))
  "Moo!")



