;; factorial helpers

(define (identity x) x)
(define (inc x) (+ x 1))

;; pi helpers

(define (plus-2 x) (+ x 2))

;; recursive
(define (product term a next b)
  (if (> a b)
      1
      (* (term a) (product term (next a) next b)))) 

(define (factorial x)
  (product identity 1 inc x))

;; iterative

(define (product-iter term a next b)
  (define (iter result a)
    (if (> a b)
	result
	(iter (* result (term a)) (next a))))
  (iter 1 a))

(define (factorial-iter x)
  (product-iter identity 1 inc x))

(define (pi iterations)
  (/ (* (product identity 2 plus-2 (+ iterations

;; tests

(newline)
(write (factorial 10))
(newline)
(write (factorial-iter 10))
