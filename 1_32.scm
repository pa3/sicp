;; iterative

(define (accumulate combiner null-value term a next b)
  (define (iter result a)
    (if (> a b)
      result
      (iter (combiner result (term a)) (next a))))
  (iter null-value a))

;; recursive

;;(define (accumulate combiner null-value term a next b)
;;  (if (> a b)
;;      null-value
;;      (combiner (term a) (accumulate combiner null-value term (next a) next b))))

(define (product term a next b)
  (accumulate * 1 term a next b))

(define (sum term a next b)
  (accumulate + 0 term a next b))

(define (identity x) x)
(define (inc x) (+ x 1))

