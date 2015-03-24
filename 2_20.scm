(define (same-parity first . tail)
  (define (filter match? list result)
    (cond ((null? list) result)
          ((match? (car list)) (filter match? (cdr list) (cons (car list) result)))
          (else (filter match? (cdr list) result))))
  (filter (if (odd? first)
              odd?
              even?)
          tail '()))

              
    
