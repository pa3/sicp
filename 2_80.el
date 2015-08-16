(load-file "2_77_generic_arithmetic.el")
(load-file "2_78.el")

(defun =zero? (n) (apply-generic '=zero? n))

((lambda ()
   (put-proc '=zero? '(lisp-number) (lambda (n) (zerop 0)))
   (put-proc '=zero? '(complex) (lambda (n) (and (zerop (real-part n)) (zerop (imag-part n)))))
   (put-proc '=zero? '(rational) (lambda (n) (zerop (numer n))))))


