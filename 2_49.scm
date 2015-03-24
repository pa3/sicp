;; a
(define (outline frame)
  (let ((segments (list 
          (make-segment (make-vect 0 0) (make-vect 0 1))
               (make-segment (make-vect 0 1) (make-vect 1 1))
               (make-segment (make-vect 1 1) (make-vect 1 0))
               (make-segment (make-vect 1 0) (make-vect 0 0)))))
    ((segments->painter segments) frame)))

;; b
(define (x-shape frame)
  (let ((segments (list 
               (make-segment (make-vect 0 0) (make-vect 1 1))
               (make-segment (make-vect 0 1) (make-vect 1 0)))))
    ((segments->painter segments) frame)))

;; c
(define (diamond frame)
  (let ((segments (list 
               (make-segment (make-vect 0 0.5) (make-vect 0.5 0))
               (make-segment (make-vect 0.5 0) (make-vect 1 0.5))
               (make-segment (make-vect 1 0.5) (make-vect 0.5 1))
               (make-segment (make-vect 0.5 1) (make-vect 0 0.5)))))
    ((segments->painter segments) frame)))
  
;; d 
;; ok, i got the idea and feel too lazy to implement this wave thing
