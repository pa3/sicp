(define (factorial n)
  (if (= n 1) 1 (* n (factorial (- n 1)))))

;; Evaluating given function with argument equals 6 will
;; lead to creation of the following set of environments:
;;
;; E1: n=6 (if (= n 1) ... )
;; E2: n=6 (* n (factorial (- n 1)))
;; E3: n=5 (if (= n 1) ... )
;; E4: n=5 (* n (factorial (- n 1)))
;; E5: n=4 (if (= n 1) ... )
;; E6: n=4 (* n (factorial (- n 1)))
;; E7: n=3 (if (= n 1) ... )
;; E8: n=3 (* n (factorial (- n 1)))
;; E9: n=2 (if (= n 1) ...
;; E10: n=2 (* n (factorial (- n 1)))
;; E11: n=1 (if (= n 1) ...

(define (factorial n) (fact-iter 1 1 n))
(define (fact-iter product counter max-count)
  (if (> counter max-count)
      product
      (fact-iter (* counter product)
                 (+ counter 1)
                 max-count)))

;; Evaluating this version of factorial function with argument 6 will lead to:
;;
;; E1: n=6 (fact-iter 1 1 n)
;; E2: product=1 counter=1 max-count=6 (if (> counter max-count) ... )
;; E3: product=1 counter=2 max-count=6 (if (> counter max-count) ... )
;; E4: product=2 counter=3 max-count=6 (if (> counter max-count) ... )
;; E5: product=6 counter=4 max-count=6 (if (> counter max-count) ... )
;; E6: product=24 counter=5 max-count=6 (if (> counter max-count) ... )
;; E7: product=120 counter=6 max-count=6 (if (> counter max-count) ... )
;; E8: product=720 counter=7 max-count=6 (if (> counter max-count) ... )
