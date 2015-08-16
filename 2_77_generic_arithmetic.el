;;; -*-lexical-binding: t;-*-

;; My implementations of `put' and `get' as Elisp use `eq' to compare
;; properties' names which makes usage a list as a property name
;; imposible. 
(defun type-tag (data) (car data))
(defun contents (data) (cdr data))

(setq proc-vtable (make-hash-table))

(defun get-proc (op type-tags)
  (gethash type-tags (gethash op proc-vtable)))
(defun put-proc (op type-tags proc)
  (unless (gethash op proc-vtable)
    (puthash op (make-hash-table :test 'equal) proc-vtable))
  (puthash type-tags proc (gethash op proc-vtable))) 

(defun apply-generic (op &rest args)
  (let* ((type-tags (mapcar 'type-tag args))
           (proc (get-proc op type-tags)))
      (if proc
          (apply proc (mapcar 'contents args))
        (error
         "No method for these types: APPLY-GENERIC %S"
         (list op type-tags)))))

;; generaic arithmetic operations

(defun add (x y) (apply-generic 'add x y))
(defun sub (x y) (apply-generic 'sub x y))
(defun mul (x y) (apply-generic 'mul x y))
(defun div (x y) (apply-generic 'div x y))

;; install lisp numbers
(defun make-lisp-number (n) (funcall (get-proc 'make 'lisp-number) n))
((lambda ()
   (let ((tag (lambda (x) x)))
   (put-proc 'make 'lisp-number (lambda (x) (funcall tag x)))
   (put-proc 'add '(lisp-number lisp-number) (lambda (x y) (funcall tag (+ x y))))
   (put-proc 'sub '(lisp-number lisp-number) (lambda (x y) (funcall tag (- x y))))
   (put-proc 'mul '(lisp-number lisp-number) (lambda (x y) (funcall tag (* x y))))
   (put-proc 'div '(lisp-number lisp-number) (lambda (x y) (funcall tag (/ x y)))))))

;; install rational numbers
(defun make-rational-number (n m) (funcall (get-proc 'make 'rational) n m))
((lambda ()
   (let ((tag (lambda (x) (cons 'rational x))))
   (defun gdc (x y) 
     (if (zerop y)
         x
       (gdc y (% x y))))
   (defun make-rat (x y)
     (if (zerop y)
         (error "Zero denominator %S" (cons x y))
       (funcall tag (let ((divisor (gdc x y))) (cons (/ x divisor) (/ y divisor))))))
   (defun numer (x) (car x))
   (defun denom (x) (cdr x))
   (put-proc 'make 'rational 'make-rat)
   (put-proc 'add '(rational rational) (lambda (x y)
                                         (make-rat
                                          (+ (* (numer x) (denom y)) (* (numer y) (denom x)))
                                          (* (denom x) (denom y)))))
   (put-proc 'sub '(rational rational) (lambda (x y)
                                         (make-rat
                                          (- (* (numer x) (denom y)) (* (numer y) (denom x)))
                                          (* (denom x) (denom y)))))
   (put-proc 'mul '(rational rational) (lambda (x y)
                                         (make-rat
                                          (* (numer x) (numer y))
                                          (* (denom x) (denom y)))))
   (put-proc 'div '(rational rational) (lambda (x y)
                                         (make-rat
                                          (* (numer x) (denom y))
                                          (* (denom x) (numer y))))))))


(defun real-part (c) (apply-generic 'real-part c))
(defun imag-part (c) (apply-generic 'imag-part c))
(defun magnitude (c) (apply-generic 'magnitude c))
(defun angle (c) (apply-generic 'angle c))
(defun add-complex (z1 z2)
  (make-from-real-imag (+ (real-part z1) (real-part z2))
                       (+ (imag-part z1) (imag-part z2))))
(defun sub-complex (z1 z2)
  (make-from-real-imag (- (real-part z1) (real-part z2))
                       (- (imag-part z1) (imag-part z2))))
(defun mul-complex (z1 z2)
  (make-from-mag-angle (* (magnitude z1) (magnitude z2))
                     (+ (angle z1) (angle z2))))
(defun div-complex (z1 z2)
  (make-from-mag-angle (/ (magnitude z1) (magnitude z2))
                     (- (angle z1) (angle z2))))

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
                                         (sqrt (+ (* r r) (* i i))))))
   (put-proc 'angle '(rectangular) (lambda (r) (atan (funcall imag-part r) (funcall real-part r)))))))

;; install polar complex numbers
(defun make-from-mag-angle (m a) (funcall (get-proc 'make 'polar) m a))
((lambda ()
   (let ((tag (lambda (p) (cons 'polar p)))
         (magnitude (lambda (p) (car p)))
         (angle (lambda (p) (cdr p))))
   (put-proc 'make 'polar (lambda (m a) (funcall tag (cons m a))))
   (put-proc 'magnitude '(polar) magnitude)
   (put-proc 'angle '(polar) angle)
   (put-proc 'real-part '(polar) (lambda (p) (* (funcall magnitude p) (cos (funcall angle p)))))
   (put-proc 'imag-part '(polar) (lambda (p) (* (funcall magnitude p) (sin (funcall angle p))))))))


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
