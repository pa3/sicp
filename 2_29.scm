(define (make-mobile left right)
  (list left right))

(define (make-branch length structure)
  (list length structure))

(define (left-branch mobile)
  (car mobile))

(define (right-branch mobile)
  (car (cdr mobile)))

(define (branch-length branch)
  (car branch))

(define (branch-structure branch)
  (car (cdr branch)))

(define (branch-weight branch)
  (let ((structure (branch-structure branch)))
    (if (pair? structure)
        (total-weight structure)
        structure)))

(define (total-weight mobile)
  (let ((left (left-branch mobile))
        (right (right-branch mobile)))
    (+ (branch-weight left) (branch-weight right))))

(define (branch-torque branch)
  (* (branch-length branch) (branch-weight branch)))

(define (balanced-mobile? mobile)
  (let ((left (left-branch mobile))
        (right (right-branch mobile)))
    (and (= (branch-torque left) (branch-torque right))
         (if (pair? (branch-structure left))
             (balanced-mobile? (branch-structure left))
             #t)
         (if (pair? (branch-structure right))
             (balanced-mobile? (branch-structure right))
             #t))))

(define mobile1 (make-mobile (make-branch 1 2) (make-branch 1 2)))
(define mobile2 (make-mobile (make-branch 1 3) (make-branch 1 1)))
(define mobile3 (make-mobile (make-branch 1 mobile1) (make-branch 1 mobile2)))
(define mobile4 (make-mobile (make-branch 1 mobile1) (make-branch 1 mobile3)))
