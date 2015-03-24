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
(define (power x y)
  (define (iter i result)
    (if (= i y)
	result
	(iter (+ i 1) (* result x))))
  (iter 1 x))


(define (nth-root x n)
  (let ( (repetitions (floor (/ (log n) (log 2)))))
    (fixed-point ((repeated average-damp repetitions) 
		(lambda (y) (/ x (expt y (- n 1))))) 1)))


