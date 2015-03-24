(define (queens board-size)
  (define (queen-cols k)  
    (if (= k 0)
        (list empty-board)
        (filter
         (lambda (positions) (safe? k positions))
         (flatmap
          (lambda (rest-of-queens)
            (map (lambda (new-row)
                   (adjoin-position new-row k rest-of-queens))
                 (enumerate-interval 1 board-size)))
          (queen-cols (- k 1))))))
  (queen-cols board-size))

(define (make-queen x y) (cons x y))
(define (x queen) (car queen))
(define (y queen) (cdr queen))
  
(define (in-check? queen1 queen2)
  (or (= (x queen1) (x queen2))
      (= (y queen1) (y queen2))
      (= (abs (- (x queen1) (x queen2))) (abs (- (y queen1) (y queen2))))))

(define (safe? k positions)
  (let ((queen-k (car (reverse positions)))
	(rest (cdr (reverse positions))))
    (= 0 (length (filter (lambda (queen-n) (in-check? queen-k queen-n))
			 rest)))))
(define empty-board '())

(define (adjoin-position new-row k rest-of-queens)
  (append rest-of-queens (list (make-queen k new-row))))

(define (flatmap proc seq)
  (accumulate append '() (map proc seq)))

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (enumerate-interval from to)
  (if (> from to)
      '()
      (cons from (enumerate-interval (+ from 1) to))))
