(in-package :create-shader)

(defmacro aif (predicate then &optional else)
  `(let ((it ,predicate))
     (if it
	 ,then
	 ,else)))

(defmacro with-lowercase-printing (&body body)
  `(let ((*print-case* :downcase)) ,@body))
