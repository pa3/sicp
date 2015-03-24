(define (reverse l)
  (define (do-reverse l result)
    (if (null? l)
        result
        (do-reverse (cdr l) (cons (car l) result))))
  (do-reverse l '()))
