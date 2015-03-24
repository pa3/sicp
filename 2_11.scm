(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (sub-interval x y)
  (make-interval (- (lower-bound x) (upper-bound y))
		 (- (upper-bound x) (lower-bound y))))

(define (mul-interval x y)
  (let ((l1 (lower-bound x))
	(l2 (lower-bound y))
	(u1 (upper-bound x))
	(u2 (upper-bound y)))
    (cond ((and (<= u1 0) (<= u2 0)) (make-interval (* u1 u2) (* l1 l2)))
	  ((and (<= u1 0) (<= l2 0) (>= u2 0)) (make-interval (* l1 u2) (* l1 l2)))
	  ((and (<= u1 0) (>= l2 0)) (make-interval (* l1 u2) (* l2 u1)))
	  ((and (<= l1 0) (>= u1 0) (<= u2 0)) (make-interval (* l2 u1 ) (* l1 l2)))
	  ((and (<= l1 0) (>= u1 0) (>= l2 0)) (make-interval (* l1 u2 ) (* u1 u2)))
	  ((and (>= l1 0) (<= u2 0)) (make-interval (* u1 l2) (* l1 u2)))
	  ((and (>= l1 0) (>= u2 0) (<= l2 0)) (make-interval (* u1 l2) (* u1 u2)))
	  ((and (>= l1 0) (>= l2 0)) (make-interval (* l1 l2) (* u1 u2)))
	  (else (make-interval (min (* l1 u2) (* u1 l2)) (max (* u1 u2) (* l1 l2)))))))

(define (div-interval x y)
  (if (or (= 0 (upper-bound y)) (= 0 (lower-bound y)))
      (error "could not divide by inteval which spans 0" y)
      (mul-interval x 
		    (make-interval (/ 1.0 (upper-bound y))
				   (/ 1.0 (lower-bound y))))))
(define (display-interval interval)
  (newline)
  (display (lower-bound interval))
  (display "...")
  (display (upper-bound interval)))


(define (make-interval a b) (cons a b))
(define (lower-bound interval) (car interval))
(define (upper-bound interval) (cdr interval))



(display-interval (add-interval (make-interval 3 4) (make-interval 5 6)))
(display-interval (mul-interval (make-interval -4 -3) (make-interval 5 6)))
(display-interval (sub-interval (make-interval 3 4) (make-interval 5 6)))
(display-interval (div-interval (make-interval 3 4) (make-interval 0 6)))
