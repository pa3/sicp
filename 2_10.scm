(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (sub-interval x y)
  (make-interval (- (lower-bound x) (upper-bound y))
		 (- (upper-bound x) (lower-bound y))))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

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
(display-interval (mul-interval (make-interval 3 4) (make-interval 5 6)))
(display-interval (sub-interval (make-interval 3 4) (make-interval 5 6)))
(display-interval (div-interval (make-interval 3 4) (make-interval 0 6)))