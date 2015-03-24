(define (deep-reverse l)
  (define (do-reverse l result)
    (cond ((null? l)  result)
	  ((not (list? l)) l)
	  (else (do-reverse (cdr l) (cons (do-reverse (car l) '()) result)))))
  (do-reverse l '()))

