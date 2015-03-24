(define (average x y) (/ (+ x y) 2 ))
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (let ((tolerance 0.00001))
      (< (abs (- v1 v2)) tolerance)))
  (define (try guess)
    (let ((next (f guess)))
      (newline)
      (display next)
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

(define (f1) (fixed-point (lambda (x) (/ (log 1000) (log x))) 1.5))
(define (f2) (fixed-point (lambda (x) (average x (/ (log 1000) (log x)))) 1.5))




