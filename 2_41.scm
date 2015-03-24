(define (enumerate from to)
  (if (> from to)
      '()
      (cons from (enumerate (+ from 1) to))))

(define (permutations s)
  (if (null? s)                    ; empty set?
      (list '())                   ; sequence containing empty set
      (map (lambda (x)
	     (map (lambda (p) (cons x p))
		  (permutations (remove (lambda (a) (= a x)) s))))
	   s)))

(define (flatmap proc seq)
  (accumulate append '() (map proc seq)))

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))


(define (unique-pairs n)
  (flatmap (lambda (i) 
	     (map (lambda (j) (cons j (cons i '()))) 
		  (enumerate 1 (- i 1))))	     
	   (enumerate 1 n)))

(define (make-pair-sum pair)
  (list (car pair) (cadr pair) (+ (car pair) (cadr pair))))

(define (prime-sum? pair)
  (prime? (+ (car pair) (cadr pair))))

(define (smallest-divisor n)
  (find-divisor n 2))
(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))
(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))

(define (prime-sum-pairs n)
  (map make-pair-sum
       (filter prime-sum? (unique-pairs n))))


(define (unique-triples n)
  (flatmap (lambda (x)
	 (flatmap (lambda (y)
		(map (lambda (z) (list z y x))
		     (enumerate 1 (- y 1))))
		(enumerate 1 (- x 1))))
              (enumerate 1 n)))

(define (find-ordered-triples n s)
  (filter (lambda (x) (= s (+ (car x) (cadr x) (cadr (cdr x)))))
          (unique-triples n)))

