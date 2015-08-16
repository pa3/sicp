; to support this changes we have to replace inside the implementation
; of complex numbers all the usages of built-in scheme (elisp in my
; case) math operations with our own generic opeartion. And also we
; have to implement some new generic operation wich are currently
; missing, like sine, cosine, square-rott and so on. 

(defun cosine (n) (apply-generic 'cosine n))
(defun sine (n) (apply-generic 'sine n))
(defun square-root (n) (apply-generic 'square-root))
(defun arctangent (x y) (apply-generic 'arctangent x y))

(defun add-complex (z1 z2)
  (make-from-real-imag (add (real-part z1) (real-part z2))
                       (add (imag-part z1) (imag-part z2))))
(defun sub-complex (z1 z2)
  (make-from-real-imag (add (real-part z1) (real-part z2))
                       (add (imag-part z1) (imag-part z2))))
(defun mul-complex (z1 z2)
  (make-from-mag-angle (mul (magnitude z1) (magnitude z2))
                     (add (angle z1) (angle z2))))
(defun div-complex (z1 z2)
  (make-from-mag-angle (div (magnitude z1) (magnitude z2))
                     (sub (angle z1) (angle z2))))

;; install rectangular complex numbers
(defun make-from-real-imag (r i) (funcall (get-proc 'make 'rectangular) r i))
((lambda ()
   (let ((tag (lambda (x) (cons 'rectangular x)))
         (real-part (lambda (r) (car r)))
         (imag-part (lambda (r) (cdr r))))
   (put-proc 'make 'rectangular (lambda (r i) (funcall tag (cons r i))))
   (put-proc 'real-part '(rectangular) real-part)
   (put-proc 'imag-part '(rectangular) imag-part)
   (put-proc 'magnitude '(rectangular) (lambda (r)
                                       (let ((r (funcall real-part r))
                                             (i (funcall imag-part r)))
                                         (square-root (add (mul r r) (mul i i))))))
   (put-proc 'angle '(rectangular) (lambda (r) (arctangent (funcall imag-part r) (funcall real-part r)))))))

;; install polar complex numbers
(defun make-from-mag-angle (m a) (funcall (get-proc 'make 'polar) m a))
((lambda ()
   (let ((tag (lambda (p) (cons 'polar p)))
         (magnitude (lambda (p) (car p)))
         (angle (lambda (p) (cdr p))))
   (put-proc 'make 'polar (lambda (m a) (funcall tag (cons m a))))
   (put-proc 'magnitude '(polar) magnitude)
   (put-proc 'angle '(polar) angle)
   (put-proc 'real-part '(polar) (lambda (p) (* (funcall magnitude p) (cosine (funcall angle p)))))
   (put-proc 'imag-part '(polar) (lambda (p) (* (funcall magnitude p) (sine (funcall angle p))))))))


;; install abstract complex numbers

(defun make-complex-from-real-imag (r i) (funcall (get-proc 'make-from-real-imag 'complex) r i))
(defun make-complex-from-mag-angle (m a) (funcall (get-proc 'make-from-mag-angle 'complex) m a))

((lambda ()
   (let* ((tag (lambda (c) (cons 'complex c)))
         (make-complex-from-mag-angle (lambda (m a) (funcall tag (make-from-mag-angle m a))))
         (make-complex-from-real-imag (lambda (r i) (funcall tag (make-from-real-imag r i)))))
     (put-proc 'make-from-real-imag 'complex make-complex-from-real-imag)
     (put-proc 'make-from-mag-angle 'complex make-complex-from-mag-angle)
     (put-proc 'add '(complex complex) (lambda (c1 c2) (funcall tag (add-complex c1 c2))))
     (put-proc 'sub '(complex complex) (lambda (c1 c2) (funcall tag (sub-complex c1 c2))))
     (put-proc 'div '(complex complex) (lambda (c1 c2) (funcall tag (div-complex c1 c2))))
     (put-proc 'mul '(complex complex) (lambda (c1 c2) (funcall tag (mul-complex c1 c2))))
     (put-proc 'real-part '(complex) 'real-part)
     (put-proc 'imag-part '(complex) 'imag-part)
     (put-proc 'angle '(complex) 'angle)
     (put-proc 'magnitude '(complex) 'magnitude))))
