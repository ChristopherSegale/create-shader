(in-package :create-shader)

(let ((rules (make-hash-table)))
  (defun add-rule (name rule)
    (setf (gethash name rules) rule))

  (defun get-rule (name)
    (gethash name rules)))

(defmacro create-rule (name &body body)
  `(add-rule ,name
	     (lambda (&rest args)
	       (let ((self ,name) (arg-count (length args)))
		 (declare (ignorable self arg-count))
		 ,@body))))

(create-rule :version
  (if (integerp (car args))
      `(format nil "#version ~a~%" ,(car args))
      (error "~a is not a valid argument for ~a" (car args) self)))

(create-rule :function
  `(format nil
	   "~a ~a~a~% {~% ~a ~%}~%"
	   (type-to-string ,(car args))
	   ,(name-to-string (cadr args))
	   ,(args-to-string (caddr args))
	   (create-shader ,@(cdddr args))))

(create-rule :in
  `(format nil
	   ,@(if (> arg-count 2)
		 (list
		  "~ain ~a ~a;~%"
		  (print-modifiers (subseq args 0 (- arg-count 2)))
		  (type-to-string (elt args (- arg-count 2)))
		  (name-to-string (car (last args))))
		 (list
		  "in ~a ~a;~%"
		  (type-to-string (first args))
		  (name-to-string (second args))))))

(create-rule :out
  `(format nil
	   ,@(if (> arg-count 2)
		 (list
		  "~aout ~a ~a;~%"
		  (print-modifiers (subseq args 0 (- arg-count 2)))
		  (type-to-string (elt args (- arg-count 2)))
		  (name-to-string (car (last args))))
		 (list
		  "out ~a ~a;~%"
		  (type-to-string (first args))
		  (name-to-string (second args))))))

(create-rule :set
  (if (> arg-count 2)
      `(format nil "~{~a~^ ~} ~a = ~a"
	       ',(mapcar #'type-to-string (subseq args 0 (- arg-count 2)))
	       ,(name-to-string (elt args (- arg-count 2)))
	       ,(print-right (car (last args))))
      `(format nil "~a = ~a"
	       ,(name-to-string (car args))
	       ,(print-right (cadr args)))))
