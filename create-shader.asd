(asdf:defsystem "create-shader"
  :description "Creates a string that is used to define a GLSL shader program."
  :version "0.0.1"
  :author "Christopher Segale"
  :license "MIT"
  :serial t
  :components ((:file "package")
	       (:module "functions"
		:depends-on ("package")
		:components ((:file "util")
			     (:file "conversion" :depends-on ("util"))
			     (:file "rules" :depends-on ("util" "conversion"))))
	       (:file "create-shader" :depends-on ("functions"))))
	       
