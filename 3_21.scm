(define (print-queue queue)
  (define (print-items items)
    (if (not (null? items))
        (let ((first (car items))
              (next (cdr items)))
          (display first)
          (if (not (null? next))
              (display " "))
          (print-items next))))
  (display "Q (")
  (print-items (front-ptr queue))
  (display ")")
  (newline))
