(define rand
  (let ((x 0))
    (define (rand-update x) (+ x 1)) ;; update placeholder
    (define (reset initial-value) (set! x initial-value))
    (define (generate)
      (set! x (rand-update x))
      x)

    (lambda (method) 
      (cond ((eq? method 'generate) (generate))
	    ((eq? method 'reset) reset)
	    (else (error "Unknown method" method))))))
