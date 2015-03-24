(define (for-each proc items)
  (if (not (null? items))
      (begin
        (proc (car items))
        (for-each proc (cdr items)))))

(for-each (lambda (x)
            (begin
              (newline)
              (display x)))
          (list 13 2 33))


      
