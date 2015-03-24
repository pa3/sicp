(define (fringe tree)
    (cond ((pair? tree) (append
                          (fringe (car tree))
                          (fringe (cdr tree))))
           ((null? tree) '())
           (else (list tree))))

(define (fringe2 tree)
  (define (do-fringe tree result)
    (cond ((null? tree) result)
          ((not (pair? tree)) (cons tree result))
          (else (do-fringe (car tree) (do-fringe (cdr tree) result)))))
  (do-fringe tree '()))

