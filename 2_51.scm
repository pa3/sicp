(define (below painter1 painter2)
  (let ((split-point (make-vect 0.0 0.5)))
    (let ((top-painter 
           (transform-painter
            painter2
            split-point
            (make-vect 1.0 0.5)
            (make-vect 1.0 1.0)))
          (bottom-painter
           (transform-painter
            painter1
            (make-vect 0.0 0.0)
            (make-vect 1.0 0.0)
            split-point)))
      (lambda (frame)
        (top-painter frame)
        (bottom-painter frame)))))


;; same in terms of already created transformations

(define (below-b painter1 painter2)
  (rotate90-ccw (beside (rotate270-ccw painter1) (rotate270-ccw painter2)))) 
