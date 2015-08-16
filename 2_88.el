(defun neg (n) (apply-generic 'neg n))

(defun install-polinomial-package ()
  (put-proc 'neg
            '(polynomial)
            (lambda (p)
              (make-poly (variable p)
                         (mapcar (lambda (term)
                                   (make-term (order term) (neg (coef term))))
                                 (term-list p)))))
  (put-proc 'sub
            '(polynomial)
            (lambda (p1 p2) (add p1 (neg p2)))))
              
