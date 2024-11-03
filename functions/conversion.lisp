(in-package :create-shader)

(defun type-to-string (glsl-type)
  (if (keywordp glsl-type)
      (with-lowercase-printing
	(princ-to-string glsl-type))
      (error "~a must be a keyword to be a valid type." glsl-type)))

(defun name-to-string (glsl-name)
  (if (symbolp glsl-name)
      (with-lowercase-printing
	(substitute #\_ #\- (princ-to-string glsl-name)))
      (error "Name must be a symbol.")))

(defun symbol-to-glsl (sym)
  (cond
    ((keywordp sym) (type-to-string sym))
    ((symbolp sym) (name-to-string sym))
    (t (error "~a is not a valid type for argument list." sym))))

(defun args-to-string (glsl-args)
  (if glsl-args
      (mapcar #'symbol-to-glsl glsl-args)
      `(format nil "()")))

(defun print-modifiers (modifiers)
  (format nil "~{~a~^, ~}" (mapcar (lambda (a)
				     (destructuring-bind (outer inner) a
				       (format nil "~a (~a = ~a) "
					       (type-to-string outer)
					       (type-to-string (car inner))
					       (cadr inner))))
				   modifiers)))

(defun print-right (right-side)
  (if (consp right-side)
      (format nil "~a(~{~a~^, ~});~%"
	      (type-to-string (car right-side))
	      (mapcar (lambda (a)
			(if (symbolp a)
			    (name-to-string a)
			    a))
		      (cdr right-side)))
      (format nil "~a;~%" (if (symbolp right-side)
			      (name-to-string right-side)
			      right-side))))
