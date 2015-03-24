(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (define (iter i result)
    (if (= i n)
	result
	(iter (+ i n) (compose f result))))
  (iter 0 f))
