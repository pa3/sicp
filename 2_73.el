;; a.
;; All the different rules of differentiation of various expressions
;; were abstracted out using data-driven style. Number? and variable?
;; predicates could not be abstracted out in the same way because it's
;; not possible to distinguish between them in the given scheme as
;; they don't have an 'operation'. In other words there is no type-tag
;; to use to get apropriate function to call. 

;; b.

(defun deriv (exp var)
  (cond ((numberp exp) 0)
        ((symbolp exp)
         (if (equal exp var) 1 0))
        (t (let ((operator (car exp))
                 (operands (cdr exp)))
             (funcall (get 'deriv operator) operands var)))))

(defun make-sum (a1 a2)
  (cond ((equal a1 0) a2)
        ((equal a2 0) a1)
        ((and (numberp a1) (numberp a2)) (+ a1 a2))
        (t (list '+ a1 a2))))

(defun make-product (m1 m2)
  (cond ((or (equal m1 0) (equal m2 0)) 0)
        ((equal m1 1) m2)
        ((equal m2 1) m1)
        ((and (numberp m1) (numberp m2)) (* m1 m2))
        (t (list '* m1 m2))))

(defun install-differentiation-rules ()
  (defun deriv-sum (exp var)
    (let ((addend (car exp))
          (augend (cadr exp)))
      (make-sum (deriv addend var)
                (deriv augend var))))
  (defun deriv-product (exp var)
    (let ((multiplier (car exp))
          (multiplicand (cadr exp)))
      (make-sum (make-product multiplier 
                              (deriv multiplicand var))
                (make-product (deriv multiplier var)
                              multiplicand))))
  (put 'deriv '+ #'deriv-sum)
  (put 'deriv '* #'deriv-product))

(install-differentiation-rules)

;; c.

(defun make-exponentiation (b e)
  (cond ((equal e 0) 1)
        ((equal e 1) b)
        ((and (numberp b) (numberp e)) (expt b e))
        (t (list '** b e))))

(defun make-subtract (a1 a2)
  (cond ((equal a1 0) a2)
        ((equal a2 0) a1)
        ((and (numberp a1) (numberp a2)) (- a1 a2))
        (t (list '- a1 a2))))

(defun install-exponentiation-rule ()
  (defun deriv-subtraction (exp var)
    (let ((s1 (car expr))
          (s2 (cadr expr)))
      (make-subtract (deriv s1 var)
                (deriv s2 var))))
  (defun deriv-exponentiation (exp var)
    (let ((base (car exp))
          (exponent (cadr exp)))
      (make-product (make-product exponent
                                   (make-exponentiation base (make-subtract exponent 1)))
                     (deriv base var))))
  (put 'deriv '- #'deriv-subtraction)
  (put 'deriv '** #'deriv-exponentiation))


(install-exponentiation-rule)

;; d.
;; The only change required is to replace all 'put' invokations as
;; follows:
;;
;; (put 'deriv '- #'deriv-subtraction)
;;  ->
;; (put '- 'deriv #'deriv-subtraction) 



