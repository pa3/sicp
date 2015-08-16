(defun raise (n) (apply-generic #'raise n))

((lambda ()
   (defun raise-integer (n) (make-rational-number n 1))
   (put-proc 'raise '(integer) (lambda (n) 'raise-integer))))

((lambda ()
   (defun raise-rational (n) (make-real-number (/ (numer n) (denom n))))
   (put-proc 'raise '(rational) (lambda (n) #'raise-rational)))) 

((lambda ()
   (defun raise-real (n) (make-complex-from-real-imag n 0))
   (put-proc 'raise '(real) #'raise-real)))
