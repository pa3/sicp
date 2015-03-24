(define (cont-frac n d k)
  (define (do-cont-frac k result)
    (if (= 0 k)
	result
	(do-cont-frac (- k 1) (/ (n k) (+ (d k) result)))))
  (do-cont-frac k 0))

(define (tan-cf x k)
  (cont-frac (lambda (i) 
	       (if (= i 1.0)
		   x
		   (- (* x x))))
	     (lambda (i) (- (* i 2 ) 1.0 ))
	     k))
