(define (iterative-improvement good-enough? improve)
  (lambda (x)
    (if (good-enough? x)
	x
	((iterative-improvement good-enough? improve) (improve x)))))

(define (closer-then-tolerance? f)
  (define tolerance 0.00001)
  (lambda (x) (< (abs (- (f x) x)) tolerance)))

(define (fixed-point f first-guess)
  ((iterative-improvement (closer-then-tolerance? f) f) first-guess))

(define (sqrt x)
  (define (average x y) (/ (+ x y) 2))
  (define (improve y) (average y (/ x y)))
  ((iterative-improvement (closer-then-tolerance? improve) improve) 1.0))

  
