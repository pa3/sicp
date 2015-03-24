(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))

(define (make-point x y) (cons x y))
(define (x-point p) (car p))
(define (y-point p) (cdr p))

(define (make-segment start-point end-point) (cons start-point end-point))
(define (start-segment segment) (car segment))
(define (end-segment segment) (cdr segment))
(define (mid-segment segment)
  (let ((start-x (x-point (start-segment segment)))
        (start-y (y-point (start-segment segment)))
        (end-x (x-point (end-segment segment)))
        (end-y (y-point (end-segment segment))))
    (make-point (/ (+ start-x end-x) 2) (/ (+ start-y end-y) 2))))

(define (make-rectangle left-top right-bottom) (cons left-top right-bottom))
(define (left-top rectangle) (car rectangle))
(define (right-bottom rectangle) (cdr rectangle))
(define (rectangle-width rectangle) (- (x-point (right-bottom rectangle)) (x-point (left-top rectangle))))
(define (rectangle-hight rectangle) (- (y-point (left-top rectangle)) (y-point (right-bottom rectangle))))
(define (perimeter rectangle) (* 2 (+ (rectangle-hight rectangle) (rectangle-width rectangle))))
(define (area rectangle) (* (rectangle-hight rectangle) (rectangle-width rectangle)))
                
;; alternative method

;;(define (make-rectangle left-edge bottom-edge)
;;  (let ((width (abs (- (x-point (start-segment bottom-edge)) (x-point (end-segment bottom-edge)))))
;;	(height (abs (- (y-point (start-segment left-edge)) (y-point (end-segment left-edge))))))
;;  (cons width height)))
;;(define (rectangle-width rectangle) (car rectangle))
;;(define (rectangle-hight rectangle) (cdr rectangle))
;;
;;(define test-rectangle (make-rectangle (make-segment (make-point 0 0) (make-point 0 -2)) (make-segment (make-point 0 -2) (make-point 2 -2))))
;;


(define test-rectangle (make-rectangle (make-point 0 0) (make-point 2 -2)))
(newline)
(display (perimeter test-rectangle))
(newline)
(display (area test-rectangle))
