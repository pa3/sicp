;;; -*-lexical-binding: t;-*-

(defun make-from-mag-ang (m a)
  (defun dispatch (op)
    (cond ((eq op 'magnitude) m)
          ((eq op 'angle) a)
          ((eq op 'real-part) (* m (cos a)))
          ((eq op 'imag-part) (* m (sin a)))
          (t (error "Unknown operation %s" op))))
  #'dispatch)

(defun apply-generic (op arg) (funcall arg op))

