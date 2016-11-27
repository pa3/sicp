(define f
  (let ((x 0))
    (lambda (n)
      (let ((prev x))
        (set! x n)
        prev))))
          
    
