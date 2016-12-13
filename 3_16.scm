(define (count-pairs x)
  (if (not (pair? x))
      0
      (+ (count-pairs (car x))
         (count-pairs (cdr x))
         1)))

;; returns 3 
(define i1 (cons '() '()))
(define i2 (cons i1 '()))
(define i3 (cons i2 '()))
(count-pairs i3)

;; returns 4
(define i1 (cons '() '()))
(define i2 (cons i1 i1))
(define i3 (cons i2 '()))
(count-pairs i3)

;; returns 7
(define i1 (cons '() '()))
(define i2 (cons i1 i1))
(define i3 (cons i2 i2))
(count-pairs i3)

;; never returns
(define i1 (cons '() '()))
(define i2 (cons i1 i1))
(define i3 (cons i2 i2))
(set-cdr! i1 i3)
(count-pairs i3)

