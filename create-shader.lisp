(in-package :create-shader)

(eval-when (:compile-toplevel :execute :load-toplevel)
  (defun create-glsl-string (forms)
    (if (> (length forms) 1)
	`(concatenate 'string ,@(mapcar #'convert-form forms))
	(convert-form (car forms))))

  (defun convert-form (form)
    (cond
      ((consp form) (form-to-glsl form))
      (t (atom-to-glsl form))))
  
  (defun form-to-glsl (form)
    (let ((name (car form)))
      (aif (get-rule name)
	   (apply it (cdr form))
	   (error "Rule ~a is undefined." name))))

  (defun atom-to-glsl (form)
    (print-right form)))

(defmacro create-shader (&rest forms)
  (create-glsl-string forms))
