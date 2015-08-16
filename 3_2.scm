(define (make-monitored func)
  (let ((times-called 0))
    (lambda (input)
      (cond ((eq? 'how-many-times? input) times-called)
	    ((eq? 'reset-count input) (begin (set! times-called 0) times-called))
	    (else (begin (set! times-called (+ 1 times-called)) (func input)))))))

