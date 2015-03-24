(define (filtered-accumulate predicate combiner null-value term a next b)
  (define (iter result a)
    (if (> a b)
      result
      (if (predicate a)
          (iter (combiner result (term a)) (next a))
          (iter result (next a)))))
  (iter null-value a))


;; helpers

(define (smallest-divisor n)
  (find-divisor n 2))
(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))
(define (divides? a b)
  (= (remainder b a) 0))
(define (prime? n)
  (= n (smallest-divisor n)))

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (square x) (* x x))
(define (inc x) (+ x 1))
(define (identity x) x)


;; a

(define (sum-of-squares-of-primes a b)
  (filtered-accumulate prime? + 0 square a inc b))

;; b

(define (product-of-relativly-prime n)
  (define (relatively-prime? x) (= (gcd x n) 1))
  (filtered-accumulate relatively-prime? * 1 jidentity 1 inc n))
