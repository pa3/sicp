(define (make-deque) (cons '() '()))
(define (empty-deque? d)
  (or
   (null? (front-node d))
   (null? (rear-node d))))
(define (front-deque d)
  (if (empty-deque? d)
      (error "Deque is empty")
      (node-value (front-node d))))
(define (rear-deque d)
  (if (empty-deque? d)
      (error "Deque is empty?")
      (node-value (rear-node d))))

(define (make-node item) (cons '() (cons item '())))
(define (prev node) (car node))
(define (next node) (cddr node))
(define (set-prev! node prev-node) (set-car! node prev-node))
(define (set-next! node next-node) (set-cdr! (cdr node) next-node))

(define (front-node d) (car d))
(define (rear-node d) (cdr d))
(define (set-front! d node) (set-car! d node))
(define (set-rear! d node) (set-cdr! d node))
(define (node-value node) (cadr node))

(define (front-insert-deque! d item)
  (let ((new-node (make-node item)))
    (if (empty-deque? d)
        (set-rear! d new-node)
        (let ((front (front-node d)))
          (set-prev! front new-node)
          (set-next! new-node front)))
    (set-front! d new-node)))

(define (rear-insert-deque! d item)
  (let ((new-node (make-node item)))
    (if (empty-deque? d)
        (set-front! d new-node)
        (let ((rear (rear-node d)))
          (set-next! rear new-node)
          (set-prev! new-node rear)))
    (set-rear! d new-node)))

(define (front-delete-deque! d)
  (if (empty-deque? d)
      (error "Deque is empty!")
      (let ((new-front-node (next (front-node d))))
        (if (not (null? new-front-node)) (set-prev! new-front-node '()))
        (set-front! d new-front-node))))

(define (rear-delete-deque! d)
  (if (empty-deque? d)
      (error "Deque is empty!")
      (let ((new-rear-node (prev (rear-node d))))
        (if (not (null? new-rear-node)) (set-next! new-rear-node '()))
        (set-rear! d new-rear-node))))

(define (print-deque d)
  (define (print-items items)
    (if (not (null? items))
        (let ((first (cadr items))
              (next (cddr items)))
          (display first)
          (if (not (null? next))
              (display " "))
          (print-items next))))
  (display "Q (")
  (print-items (car d))
  (display ")")
  (newline))


(define d (make-deque))
(rear-insert-deque! d 3)
(rear-insert-deque! d 4)
(front-insert-deque! d 2)
(front-insert-deque! d 1)
                    
