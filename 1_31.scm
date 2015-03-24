;; recursive product function
;;
;;(define (product term a next b)
;;  (if (> a b)
;;      1
;;      (* (term a) (product term (next a) next b)))) 

;; iterative product function

(define (product term a next b)
  (define (iter result a)
    (if (> a b)
	result
	(iter (* result (term a)) (next a))))
  (iter 1 a))

;; factorial helpers

(define (identity x) x)
(define (inc x) (+ x 1))

;; pi helpers

(define (pi-next x) (+ x 2))
(define (pi-term x) (/ (* x (+ x 2)) (* (+ x 1) (+ x 1))))

(define (factorial x)
  (product identity 1 inc x))

(define (pi n)
  (* (product pi-term 2 pi-next n) 4.0))
