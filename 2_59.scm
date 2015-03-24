(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

(define (adjoin-set x set)
  (if (element-of-set? x set)
      set
      (cons x set)))

(define (intertsection-set set1 set2)
  (cond ((or (null? set1) (null? set2)) '())
        ((element-of-set? (car set2) set1) 
         (cons (car set2) (intertsection-set (cdr set2) set1)))
        (else (intertsection-set (cdr set2) set1))))

(define (union-set set1 set2)
  (cond ((null? set2) set1)
        ((not (element-of-set? (car set2) set1))
         (cons (car set2) (union-set set1 (cdr set2))))
        (else (union-set set1 (cdr set2)))))

;; or like that:

;; (define (union-set set1 set2)
;;   (append set1 (filter (lambda (x) (not (element-of-set? x set1)) set2)))  

;; or even like that:

;; (define (union-set set1 set2)
;;   (fold-right adjoin-set set1 set2))

  
