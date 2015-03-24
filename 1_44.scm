(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (define (iter i result)
    (if (= i n)
	result
	(iter (+ i 1) (compose f result))))
  (iter 1 f))

(define tolerance 0.00001)
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))


(define (average-damp f)
  (lambda (x) (/ (+ x (f x)) 2)))

(fixed-point ((repeated average-damp 2) (lambda (y) (/ 10.0 (* y y y y y y y)))) 1)

