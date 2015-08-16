(define (make-accumulator initial-amount)
  (lambda (amount-to-add)
    (begin (set! initial-amount (+ initial-amount amount-to-add))
           initial-amount)))                 
