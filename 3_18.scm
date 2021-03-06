(define (cycle? x)
  (define (last-pair? x) (null? (cdr x)))
  (define (cycle?-inner x visited)
    (cond ((memq x visited) #t)
          ((last-pair? x) #f)
          (else (cycle?-inner (cdr x) (cons x visited)))))
  (cycle?-inner x '()))
