(define (random-in-range low high)
  (let ((decimal-part 100000000)
	(range (- high low)))
    (+ low (/ (random (* decimal-part range)) decimal-part))))

(define (monte-carlo trials experiment)
  (define (iter trials-remaining trials-passed)
    (cond ((= trials-remaining 0)
	   (/ trials-passed trials))
	  ((experiment)
	   (iter (- trials-remaining 1)
		 (+ trials-passed 1)))
	  (else
	   (iter (- trials-remaining 1)
		 trials-passed))))
  (iter trials 0))


(define (estimate-integral P x1 x2 y1 y2 trials)
  (let ((bounds-area (* (- x2 x1) (- y2 y1))))
    (* bounds-area (monte-carlo trials (lambda ()
					 (P (random-in-range x1 x2)
					    (random-in-range y1 y2)))))))

(define (unit-circle x y) (< (+ (* x x) (* y y)) 1))

