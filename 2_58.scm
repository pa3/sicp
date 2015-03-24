(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var)))
        ((product? exp)
         (make-sum
           (make-product (multiplier exp)
                         (deriv (multiplicand exp) var))
           (make-product (deriv (multiplier exp) var)
                         (multiplicand exp))))
        ((exponentiation? exp)
         (make-product (make-product (exponent exp) 
                                     (make-exponentiation (base exp) (make-sum (exponent exp) -1)))
                       (deriv (base exp) var)))
        (else
         (error "unknown expression type -- DERIV" exp))))
(define (variable? x) (symbol? x))

(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (sum? exp)
  (and (pair? exp) (has-operation? exp '+)))

(define (addend s) (left-term s '+))

(define (augend s) (right-term s '+))

(define (product? x)
  (and (pair? x) (not (sum? x)) (has-operation? x '*)))

(define (multiplier p) (left-term p '*))
(define (multiplicand p) (right-term p '*))
  
(define (has-operation? expression operation) (there-exists? expression (lambda(x) (eq? x operation))))

(define (left-term expression operation)
  (unwrap-if-one-element (take-while (lambda(x) (not (eq? x operation))) expression)))

(define (right-term expression operation)
  (unwrap-if-one-element (cdr (drop-while (lambda(x) (not (eq? x operation))) expression))))
  
(define (drop-while predicate list)
  (cond ((null? list) '())
        ((predicate (car list)) (drop-while predicate (cdr list)))
        (else list)))

(define (take-while predicate list-to-filter)
  (define (do-take-while list-to-filter result)
    (cond ((null? list-to-filter) result)
          ((predicate (car list-to-filter)) (do-take-while (cdr list-to-filter) (append result (list (car list-to-filter)))))
          (else result)))
  (do-take-while list-to-filter '()))

(define (unwrap-if-one-element list)
  (if (= (length list) 1)
      (car list)
      list))


(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (+ a1 a2))
        (else (list a1 '+ a2))))

(define (=number? exp num)
  (and (number? exp) (= exp num)))

(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) (* m1 m2))
        (else (list m1 '* m2))))

(define (exponentiation? exp)
  (and (pair? exp) (eq? (cadr exp) '**)))

(define (base exp) (car exp))

(define (exponent exp) (caddr exp))

(define (make-exponentiation b e)
  (cond ((=number? e 0) 1)
        ((=number? e 1) b)
        ((and (number? b) (number? e)) (expt b e))
        (else (list b '** e))))
