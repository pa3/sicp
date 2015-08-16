(defun type-tag (data)
  (if (numberp data)
      'lisp-number
    (car data)))
(defun contents (data)
  (if (numberp data)
      data
    (cdr data)))
(defun attach-tag (tag data)
  (if (numberp data)
      data
    (cons tag data)))
