(define (cont-frac n d k)
  (define (do-cont-frac k result)
    (if (= 0 k)
	result
	(do-cont-frac (- k 1) (/ (n k) (+ (d k) result)))))
  (do-cont-frac k 0))


(define (euler-e steps)
  (+ 2 (cont-frac (lambda (i) 1.0)
		  (lambda (i) 
		    (if (= (remainder i 3) 2)
			(* 2 (/ (+ i 1) 3))
			1))
		  steps)))
