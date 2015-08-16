(load-file "2_77_generic_arithmetic.el")
(load-file "2_78.el")

(defun eql? (n1 n2) (apply-generic 'eql? n1 n2))

((lambda ()
   (put-proc 'eql? '(lisp-number lisp-number) (lambda (n1 n2) (= n1 n2)))
   (put-proc 'eql? '(complex complex) (lambda (n1 n2) (and (= (real-part n1) (real-part n2)) (= (imag-part n1) (imag-part n2)))))
   (put-proc 'eql? '(rational rational) (lambda (n1 n2)
                                          (or (and (= (numer n1) 0) (= (numer n2) 0))
                                              (and
                                               (= (denom n1) (denom n2))
                                               (= (numer n1) (numer n2))))))))



