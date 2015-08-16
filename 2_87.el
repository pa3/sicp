(defun install-polinomial-package ()
  (put-proc '=zero?
            '(polynomial)
            (lambda (p)
              (or (empty-termlist? p)
                  (every (lambda (term)
                           (=zero? (coef term)))
                         (term-list p))))))
