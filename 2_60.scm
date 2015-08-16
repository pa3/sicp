
;; still O(n) compared to 2.59

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

;; O(1). Was O(n) in 2.59 
(define adjoin-set cons)

;; O(n) here and O(n*n) in 2.59 
(define (union-set set1 set2)
  (if (null? set1)
      set2
      (union-set (cdr set1) (cons (car set1) set2))))

;; still O(n*n)
(define (intersection-set set1 set2)
  (cond ((or (null? set1) (null? set2)) '())
        ((element-of-set? (car set1) set2) 
         (cons (car set1) (intersection-set (cdr set1) set2)))
        (else (intersection-set (cdr set1) set2))))


(union-set '(1 2 3) '(2 3 4))
